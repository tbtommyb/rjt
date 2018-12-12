{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.Home where

import qualified Data.Text.Lazy as L
import Text.Hamlet
import Text.Markdown

import qualified Views.Partials.Header as Header (partial)
import qualified Views.Pages.Home.Contact as Contact (partial)
import Content

partial :: Content.Homepage -> Html
partial content = $(shamletFile "src/Views/Pages/Home/body.hamlet")
