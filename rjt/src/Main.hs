{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.Monoid((<>))
import Web.Scotty
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Text.Hamlet

layout :: Html -> Html -> Html -> Html -> Html
layout head nav body footer = $(shamletFile "src/default.hamlet")

template :: String -> Html -> Html
template title content = layout (Main.head title) nav content footer

head :: String -> Html
head title  = $(shamletFile "src/head.hamlet")

nav :: Html
nav = $(shamletFile "src/nav.hamlet")

footer :: Html
footer = $(shamletFile "src/footer.hamlet")

homepage :: String -> Html
homepage name = $(shamletFile "src/body.hamlet")

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/hello/:name" $ do
      name <- param "name"
      Web.Scotty.text ("Hello " <> name <> "!")
    get "/test" $ do
      html $ renderHtml $ template "New title" (homepage "tom")
    get "/custom.css" $ do
      file "src/custom.css"
