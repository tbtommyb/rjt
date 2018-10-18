{-# LANGUAGE OverloadedStrings #-}

module Main where

import Config
import Data.Maybe
import Data.Aeson
import Data.Text.Lazy
import Text.Markdown
import Views.Layout as Layout
import Views.Pages.Home.Home as Home
import Views.Pages.Packages.Packages as Packages
import Views.Pages.Testimonials.Testimonials as Testimonials
import Views.Pages.Videos.Videos as Videos
import System.FilePath
import Web.Scotty hiding (body, header)
import Text.Blaze.Html.Renderer.Text
import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString.Lazy as B

renderHomepage :: ActionM ()
renderHomepage = html $ renderHtml $ Layout.app "RJ Transformations" Home.partial

renderPackages :: ActionM ()
renderPackages = do
  content <- liftIO $ Packages.partial "Packages"
  html $ renderHtml $ Layout.app "Packages" content

renderTestimonials :: ActionM ()
renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

renderVideos :: ActionM ()
renderVideos = do
  videoContent <- liftIO $ readFile "src/videos.md"
  html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ pack videoContent

main :: IO ()
main = do
  config <- B.readFile "src/config.json"
  let cfg = decode config :: Maybe Config.Config
  print cfg
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/" $ renderHomepage
    get "/index.html" $ renderHomepage
    get "/packages" $ renderPackages
    get "/testimonials" $ renderTestimonials
    get "/videos" $ renderVideos
    -- TODO: maybe replace with middleware
    get "/:dirname/:filename" $ do
      dirname <- param "dirname"
      filename <- param "filename"
      file $ "src" </> dirname </> filename
