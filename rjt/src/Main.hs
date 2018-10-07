{-# LANGUAGE OverloadedStrings #-}

module Main where

import Templates
import System.FilePath
import Web.Scotty hiding (body, header)
import Text.Blaze.Html.Renderer.Text (renderHtml)

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/" $ do
      html $ renderHtml $ template "RJ Transformations" (body header aboutPartial contactPartial)
    -- TODO: maybe replace with middleware
    get "/:dirname/:filename" $ do
      dirname <- param "dirname"
      filename <- param "filename"
      file $ "src" </> dirname </> filename
