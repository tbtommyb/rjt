{-# LANGUAGE TemplateHaskell #-}

module Views.Partials.Footer where

import Text.Hamlet

data SocialIcon = SocialIcon { siClass :: String
                             , siLink :: String
                             } deriving (Show)

title :: String
title = "Connect with me"

socials :: [SocialIcon]
socials = [
  SocialIcon {
      siClass="fa-instagram",
      siLink="https://www.instagram.com/rjtransformations/"
      }
  ]

footer :: String -> [SocialIcon] -> Html
footer title socials = $(shamletFile "src/Views/Partials/footer.hamlet")

partial :: Html
partial = footer title socials
