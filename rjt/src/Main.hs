{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.Monoid((<>))
import Data.Text.Lazy (Text)
import Web.Scotty
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Text.Hamlet

template :: String -> Html -> Html
template name footer = $(shamletFile "src/test.hamlet")

footer :: Html
footer = $(shamletFile "src/footer.hamlet")

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 4000 $ do
    get "/hello/:name" $ do
      name <- param "name"
      Web.Scotty.text ("Hello " <> name <> "!")
    get "/test" $ do
      html $ renderHtml $ template "tom" footer
