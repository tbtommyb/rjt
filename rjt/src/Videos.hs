module Videos where

newtype Instagram = Instagram { instaPath :: String } deriving (Show, Eq)
newtype Youtube = Youtube { ytPath :: String } deriving (Show, Eq)

instagram :: [Instagram]
instagram = [
  Instagram "BISfT2KDjQp",
  Instagram "BI-Kz2wD1z0",
  Instagram "BNM39AsF9HR",
  Instagram "BL0yY9BlPv3"
  ]

youtube :: [Youtube]
youtube = []
