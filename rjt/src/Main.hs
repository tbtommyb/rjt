{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import qualified Web.Scotty ()
import Web.Scotty.Trans as S
import Network.Wai (Middleware)
import Network.Wai.Middleware.Routed
import Network.Wai.Middleware.HttpAuth

import Control.Monad.Trans.Class (lift)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader (asks)

import Content
import Data.Maybe
import Data.Aeson

import qualified Data.ByteString.Lazy as B
import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import Text.Markdown
import System.FilePath
import Text.Blaze.Html.Renderer.Text

import Database as DB
import Internal

import Views.Layout as Layout
import Views.Pages.Home.Home as Home
import Views.Pages.Packages.Packages as Packages
import Views.Pages.Testimonials.Testimonials as Testimonials
import Views.Pages.Videos.Videos as Videos

import Views.Admin.Users.Users as Users

import Models.User as UserModel

renderHomepage :: ActionT L.Text ConfigM ()
renderHomepage = do
  content <- lift $ asks getContent
  let homeContent = homePage $ content
  html $ renderHtml $ Layout.app (T.unpack $ title $ homeContent) Home.partial

renderPackages :: ActionT L.Text ConfigM ()
renderPackages = do
  content <- liftIO $ Packages.partial "Packages"
  html $ renderHtml $ Layout.app "Packages" content

renderTestimonials :: ActionT L.Text ConfigM ()
renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

renderVideos :: ActionT L.Text ConfigM ()
renderVideos = do
  videoContent <- liftIO $ readFile "src/videos.md"
  html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ L.pack videoContent

main :: IO ()
main = do
  pool <- DB.setup "dev.db" 3
  jsonConfig <- B.readFile "src/config.json"
  let content = case decode jsonConfig :: Maybe Content.Content of
        Nothing -> error "Could not read config.json file"
        Just c -> c
  let config = Config { getPool = pool, getContent = content }
  scottyT 4000 (runIO config) =<< runIO config application

authorise :: Middleware
authorise = basicAuth (\u p -> return $ u == "roland" && p == "pass") "Enter admin username and password"

-- Main application
application :: ConfigM (ScottyT L.Text ConfigM ())
application = do
    return $ do
      middleware $ routedMiddleware ("admin" `elem`) authorise
      S.get "/" $ renderHomepage
      S.get "/index.html" $ renderHomepage
      S.get "/packages" $ renderPackages
      S.get "/testimonials" $ renderTestimonials
      S.get "/videos" $ renderVideos
      S.get "/admin/users" $ do
        lift Users.index >>= html . renderHtml
      S.get "/admin/users/:userId" $ do
        userId <- param "userId"
        lift (Users.show userId) >>= html . renderHtml
      S.post "/admin/users" $ do
        firstName <- param "firstName"
        surname <- param "surname"
        email <- param "email"
        _ <- lift $ UserModel.create firstName surname email
        redirect "/admin/users/"
      -- TODO: maybe replace with middleware
      S.get "/:dirname/:filename" $ do
        dirname <- param "dirname"
        filename <- param "filename"
        file $ "src" </> dirname </> filename
