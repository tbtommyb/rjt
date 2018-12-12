{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Packages.Packages where

import qualified Data.Text.Lazy as L
import Text.Hamlet
import Text.Markdown

import Content

partial :: Content.PackagesPage -> Html
partial content = $(shamletFile "src/Views/Pages/Packages/packages.hamlet")
