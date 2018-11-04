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

-- import Config
-- import Data.Maybe
-- import Data.Aeson
-- import qualified Data.ByteString.Lazy as B
import qualified Data.Text.Lazy as T
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

renderHomepage :: ActionT T.Text ConfigM ()
renderHomepage = html $ renderHtml $ Layout.app "RJ Transformations" Home.partial

renderPackages :: ActionT T.Text ConfigM ()
renderPackages = do
  content <- liftIO $ Packages.partial "Packages"
  html $ renderHtml $ Layout.app "Packages" content

renderTestimonials :: ActionT T.Text ConfigM ()
renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

renderVideos :: ActionT T.Text ConfigM ()
renderVideos = do
  videoContent <- liftIO $ readFile "src/videos.md"
  html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ T.pack videoContent

main :: IO ()
main = do
  pool <- DB.setup "dev.db" 3
  let config = Config { getPool = pool }
  scottyT 4000 (runIO config) =<< runIO config application

authorise :: Middleware
authorise = basicAuth (\u p -> return $ u == "roland" && p == "pass") "Enter admin username and password"

-- Main application
application :: ConfigM (ScottyT T.Text ConfigM ())
application = do
    return $ do
      middleware $ routedMiddleware ("admin" `elem`) authorise
      S.get "/" $ renderHomepage
      S.get "/index.html" $ renderHomepage
      S.get "/packages" $ renderPackages
      S.get "/testimonials" $ renderTestimonials
      S.get "/videos" $ renderVideos
      S.get "/admin" $ do
        lift Users.index >>= html . renderHtml
      -- TODO: maybe replace with middleware
      S.get "/:dirname/:filename" $ do
        dirname <- param "dirname"
        filename <- param "filename"
        file $ "src" </> dirname </> filename
