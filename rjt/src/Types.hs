module Types where

newtype Instagram = Instagram { instaPath :: String } deriving (Show, Eq)
newtype Youtube = Youtube { ytPath :: String } deriving (Show, Eq)
