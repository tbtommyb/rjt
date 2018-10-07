module Footer where

data SocialIcon = SocialIcon { siClass :: String
                             , siLink :: String
                             } deriving (Show)

title :: String
title = "Connect with me"

socials :: [SocialIcon]
socials = [
  SocialIcon {siClass="fa-instagram", siLink="https://www.instagram.com/rjtransformations/"}
  ]
