{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text.Lazy
import Text.Markdown
import Views.Layout as Layout
import Views.Pages.Home.Home as Home
import Views.Pages.Testimonials.Testimonials as Testimonials
import Views.Pages.Videos.Videos as Videos
import System.FilePath
import Web.Scotty hiding (body, header)
import Text.Blaze.Html.Renderer.Text
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/" $ do
      html $ renderHtml $ Layout.app "RJ Transformations" Home.partial
    get "/packages" $ do
      packages <- liftIO $ readFile "src/packages.md"
      html $ renderHtml $ Layout.app "Packages" (Layout.single "Packages" (markdown def (pack packages)))
    get "/testimonials" $ do
      html $ renderHtml $ Layout.app "Testimonials" (Testimonials.partial "Testimonials")
    get "/videos" $ do
      videoContent <- liftIO $ readFile "src/videos.md"
      html $ renderHtml $ Layout.app "Videos" (Videos.partial "Videos" (markdown def (pack videoContent)))
    -- TODO: maybe replace with middleware
    get "/:dirname/:filename" $ do
      dirname <- param "dirname"
      filename <- param "filename"
      file $ "src" </> dirname </> filename
