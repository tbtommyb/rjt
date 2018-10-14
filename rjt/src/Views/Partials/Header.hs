{-# LANGUAGE TemplateHaskell #-}

module Views.Partials.Header where

import Text.Hamlet

partial :: Html
partial = $(shamletFile "src/Views/Partials/header.hamlet")
