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

videos :: String -> Html -> [Instagram] -> [Youtube] -> Html
videos title content igVideos ytVideos = $(shamletFile "src/Views/Pages/Videos/videos.hamlet")

partial :: String -> Html -> Html
partial title content = videos title content instagram youtube
