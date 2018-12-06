{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import Web.Scotty
-- import Web.Scotty.Trans as S
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth

import Control.Monad.Trans.Class (lift)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.State (gets, evalStateT, runStateT, execStateT)

import Content

import qualified Data.Text.Lazy as L
import Text.Markdown
import System.FilePath
import Text.Blaze.Html.Renderer.Text

import Database as DB
import Internal

import Views.Layout as Layout
import Views.Pages.Packages.Packages as Packages
import Views.Pages.Testimonials.Testimonials as Testimonials
import Views.Pages.Videos.Videos as Videos
import Views.Admin.Users.Users as Users

import Controllers.Homepage as HomepageController
import Controllers.Admin as AdminController (adminController)

import Models.User as UserModel
import Data.JsonState
import Data.Time.Units

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
  scotty 4000 $ application config

authorise :: Middleware
authorise = basicAuth (\u p -> return $ u == "roland" && p == "pass") "Enter admin username and password"

runMiddlewares :: ScottyM ()
runMiddlewares = do
  middleware $ routedMiddleware ("admin" `elem`) authorise

application :: Config -> ScottyM ()
application config = do
  runMiddlewares
  homepageController config
  adminController config
  -- S.get "/" $ do
  --   evalStateT handler config
  -- pure $ middleware $ routedMiddleware ("admin" `elem`) authorise
  -- return $ homepageController
  -- adminController
      -- S.get "/packages" $ renderPackages
      -- S.get "/testimonials" $ renderTestimonials
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
      -- -- TODO: maybe replace with middleware
      -- S.get "/:dirname/:filename" $ do
      --   dirname <- param "dirname"
      --   filename <- param "filename"
      --   file $ "src" </> dirname </> filename
