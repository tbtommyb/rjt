{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import Web.Scotty.Trans
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth
import Network.Wai.Middleware.Static

import Control.Monad.IO.Class (liftIO)
import Control.Concurrent.STM
import Control.Monad.Reader (runReaderT)

import Content

import qualified Data.Text.Lazy as L

import Database as DB
import Internal

import Controllers.Homepage (homepageController)
import Controllers.Admin (adminController)
import Controllers.Testimonials (testimonialsController)
import Controllers.Packages (packagesController)
import Controllers.Videos (videosController)

import Data.JsonState


main :: IO ()
main = do
  pool <- DB.setup "dev.db" 3
  jsonConfig <- liftIO $ loadState "src/config.json" :: IO (Either (Bool, String) Content.Content)
  let content = case jsonConfig of
        Left (_, e) -> error e
        Right s -> s
  let config = Config { getPool = pool, appContent = content }
  sync <- newTVarIO config
  let runActionToIO m = runReaderT (runWebM m) sync
  scottyT 4000 runActionToIO application

authorise :: Middleware
authorise = basicAuth (\u p -> return $ u == "roland" && p == "pass") "Enter admin username and password"

runMiddlewares :: ScottyT L.Text WebM ()
runMiddlewares = do
  middleware $ routedMiddleware ("admin" `elem`) authorise
  middleware $ staticPolicy (noDots >-> addBase "src")

application :: ScottyT L.Text WebM ()
application = do
  runMiddlewares
  homepageController
  adminController
  testimonialsController
  packagesController
  videosController
