{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import System.FilePath
import Web.Scotty
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Text.Hamlet

-- TODO: tidy up all of these template functions
layout :: Html -> Html -> Html -> Html -> Html
layout head nav body footer = $(shamletFile "src/default.hamlet")

template :: String -> Html -> Html
template title content = layout (Main.head title) nav content footer

body :: Html -> Html -> Html
body header about = $(shamletFile "src/body.hamlet")

header :: Html
header = $(shamletFile "src/header.hamlet")

about :: Html
about = $(shamletFile "src/about.hamlet")

head :: String -> Html
head title  = $(shamletFile "src/head.hamlet")

nav :: Html
nav = $(shamletFile "src/nav.hamlet")

footer :: Html
footer = $(shamletFile "src/footer.hamlet")

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/" $ do
      html $ renderHtml $ template "RJ Transformations" (Main.body Main.header about)
    get "/:dirname/:filename" $ do
      dirname <- param "dirname"
      filename <- param "filename"
      file $ "src" </> dirname </> filename
