{-# LANGUAGE TemplateHaskell #-}

module Views.Partials.Head where

import Text.Hamlet

partial :: String -> Html
partial title  = $(shamletFile "src/Views/Partials/head.hamlet")
