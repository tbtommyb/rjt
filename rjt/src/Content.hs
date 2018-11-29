{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Content where

import Data.Aeson
import GHC.Generics
import Data.Text

data Content =
  Content { homePage :: Homepage } deriving (Show, Generic, ToJSON, FromJSON)

data Homepage =
  Homepage { title :: Text
           , imgPath :: Text
           , paragraphs :: [Text]
           , videoParagraphs :: [Text]
           , videoSlug :: Text
           } deriving (Show, Generic, ToJSON, FromJSON)
