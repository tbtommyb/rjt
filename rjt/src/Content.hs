{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Content where

import Data.Aeson
import GHC.Generics
import Data.Text

data Content =
  Content { homePage :: Homepage } deriving (Show, Generic, ToJSON, FromJSON)

data Homepage =
  Homepage { title :: String
           , tabTitle :: String
           , profileImgPath :: String
           , paragraphs :: String
           , videoParagraphs :: String
           , videoSlug :: Text
           } deriving (Show, Generic, ToJSON, FromJSON)
