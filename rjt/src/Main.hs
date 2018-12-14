{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Concurrent.STM
import Control.Monad.Reader (runReaderT)
import System.Environment

import Web.Scotty.Trans
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth
import Network.Wai.Middleware.Static
import qualified Data.Text.Lazy as L
import qualified Data.ByteString.Char8 as B
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
  password <- liftIO $ getEnv "RJT_PASSWORD"
  sync <- newTVarIO config
  let runActionToIO m = runReaderT (runWebM m) sync
  scottyT 4000 runActionToIO (application password)

authorise :: String -> Middleware
authorise password = basicAuth (\u p -> return $ u == "roland" && p == B.pack password) "Enter admin username and password"

runMiddlewares :: String -> ScottyT L.Text WebM ()
runMiddlewares password = do
  middleware $ routedMiddleware ("admin" `elem`) (authorise password)
  middleware $ staticPolicy (noDots >-> addBase "src/static")

application :: String -> ScottyT L.Text WebM ()
application password = do
  runMiddlewares password
  homepageController
  adminController
  testimonialsController
  packagesController
  videosController
