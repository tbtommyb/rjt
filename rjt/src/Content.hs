{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Content where

import Data.Aeson
import GHC.Generics
import Data.Text

data Content =
  Content { homePage :: Homepage
          , testimonialsPage :: TestimonialsPage
          , packagesPage :: PackagesPage
          } deriving (Show, Generic, ToJSON, FromJSON)

data Homepage =
  Homepage { title :: String
           , tabTitle :: String
           , profileImgPath :: String
           , paragraphs :: String
           , videoParagraphs :: String
           , videoSlug :: Text
           } deriving (Show, Generic, ToJSON, FromJSON)

data TestimonialsPage =
  TestimonialsPage { testimonialsPageTitle :: String
                   , testimonialsPageContent :: String
                  , testimonials :: [Testimonial]
                  } deriving (Show, Generic, ToJSON, FromJSON)

data Testimonial =
  Testimonial { testimonialName :: String
              , testimonialImgSrc :: Maybe String
              , testimonialContent :: String
              } deriving (Show, Generic, ToJSON, FromJSON)

data PackagesPage =
  PackagesPage { packagesPageTitle :: String
               , packagesIntroContent :: String
               , packages :: [Package]
               , packagesSupplementaryContent :: String
               , packagesButtonLabel :: String
               } deriving (Show, Generic, ToJSON, FromJSON)

data Package =
  Package { packageName :: String
          , packageDescription :: String
          } deriving (Show, Generic, ToJSON, FromJSON)
