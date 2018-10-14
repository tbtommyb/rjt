{-# LANGUAGE OverloadedStrings #-}

module Main where

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

renderHomepage :: ActionM ()
renderHomepage = html $ renderHtml $ Layout.app "RJ Transformations" Home.partial

renderPackages :: ActionM ()
renderPackages = html $ renderHtml $ Layout.app "Packages" $ Packages.partial "Packages"

renderTestimonials :: ActionM ()
renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

renderVideos :: ActionM ()
renderVideos = do
  videoContent <- liftIO $ readFile "src/videos.md"
  html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ pack videoContent

main :: IO ()
main = do
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
