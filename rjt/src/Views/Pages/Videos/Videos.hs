{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Videos.Videos where

import qualified Data.Text.Lazy as L
import Text.Hamlet
import Text.Markdown

import Content

partial :: Content.VideosPage -> Html
partial content = $(shamletFile "src/Views/Pages/Videos/videos.hamlet")
