{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Concurrent.STM
import Control.Monad.Reader (runReaderT)

import Web.Scotty.Trans
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth
import Network.Wai.Middleware.Static
import qualified Data.Text.Lazy as L
import Data.JsonState

import Content
import Internal

import Controllers.Homepage (homepageController)
import Controllers.Admin (adminController)
import Controllers.Testimonials (testimonialsController)
import Controllers.Packages (packagesController)
import Controllers.Videos (videosController)

main :: IO ()
main = do
  jsonConfig <- liftIO $ loadState "src/config.json" :: IO (Either (Bool, String) Content.Content)
  let content = case jsonConfig of
        Left (_, e) -> error e
        Right s -> s
  let config = Config { appContent = content }
  sync <- newTVarIO config
  let runActionToIO m = runReaderT (runWebM m) sync
  scottyT 4000 runActionToIO application

authorise :: Middleware
authorise = basicAuth (\u p -> return $ u == "roland" && p == "pass") "Enter admin username and password"

runMiddlewares :: ScottyT L.Text WebM ()
runMiddlewares = do
  middleware $ routedMiddleware ("admin" `elem`) authorise
  middleware $ staticPolicy (noDots >-> addBase "src/static")

application :: ScottyT L.Text WebM ()
application = do
  runMiddlewares
  homepageController
  adminController
  testimonialsController
  packagesController
  videosController
