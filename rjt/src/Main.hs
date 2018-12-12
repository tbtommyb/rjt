{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import Web.Scotty.Trans
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth

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
import Controllers.Static (staticController)

import Data.JsonState

-- renderPackages :: ActionT L.Text ConfigM ()
-- renderPackages = do
--   content <- liftIO $ Packages.partial "Packages"
--   html $ renderHtml $ Layout.app "Packages" content

-- renderTestimonials :: ActionT L.Text ConfigM ()
-- renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

-- renderVideos :: ActionT L.Text ConfigM ()
-- renderVideos = do
--   videoContent <- liftIO $ readFile "src/videos.md"
--   html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ L.pack videoContent

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

application :: ScottyT L.Text WebM ()
application = do
  runMiddlewares
  homepageController
  adminController
  testimonialsController
  staticController
      -- S.get "/packages" $ renderPackages
      -- S.get "/videos" $ renderVideos
      -- adminController content
      -- S.get "/admin/users" $ do
      --   lift Users.index >>= html . renderHtml
      -- S.get "/admin/users/:userId" $ do
      --   userId <- param "userId"
      --   lift (Users.show userId) >>= html . renderHtml
      -- S.post "/admin/users" $ do
      --   firstName <- param "firstName"
      --   surname <- param "surname"
      --   email <- param "email"
      --   _ <- lift $ UserModel.create firstName surname email
      --   redirect "/admin/users/"
