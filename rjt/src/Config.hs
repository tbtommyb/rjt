{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Config where

import Data.Aeson
import GHC.Generics
import Data.Text

data Config =
  Config { homePage :: Homepage } deriving (Show, Generic, ToJSON, FromJSON)

data Homepage =
  Homepage { title :: Text
           , imgPath :: Text
           , paragraphs :: [Text]
           , videoParagraphs :: [Text]
           , videoSlug :: Text
           } deriving (Show, Generic, ToJSON, FromJSON)
