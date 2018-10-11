{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text.Lazy
import Text.Markdown
import Templates
import System.FilePath
import Web.Scotty hiding (body, header)
import Text.Blaze.Html.Renderer.Text
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/" $ do
      html $ renderHtml $ template "RJ Transformations" (home header aboutPartial contactPartial)
    get "/packages" $ do
      packages <- liftIO $ readFile "src/packages.md"
      html $ renderHtml $ template "Packages" (singlePartial "Packages" (markdown def (pack packages)))
    -- TODO: maybe replace with middleware
    get "/:dirname/:filename" $ do
      dirname <- param "dirname"
      filename <- param "filename"
      file $ "src" </> dirname </> filename
