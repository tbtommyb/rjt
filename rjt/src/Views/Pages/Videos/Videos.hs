{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Videos.Videos where

import Text.Hamlet

import Types

instagram :: [Instagram]
instagram = [
  Instagram "BISfT2KDjQp",
  Instagram "BI-Kz2wD1z0",
  Instagram "BNM39AsF9HR",
  Instagram "BL0yY9BlPv3"
  ]

youtube :: [Youtube]
youtube = []

partial :: Html -> Html
partial content = $(shamletFile "src/Views/Pages/Videos/videos.hamlet")
