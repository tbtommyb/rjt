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

partial :: Html
partial = $(shamletFile "src/Views/Partials/footer.hamlet")
