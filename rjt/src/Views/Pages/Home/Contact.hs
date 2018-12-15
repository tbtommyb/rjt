{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.Contact where

import Text.Hamlet

import Content

data FormItem = FormItem { fLabel :: String
                         , fInput :: String
                         , fName :: String
                         , fMessage :: Maybe String
                         } deriving (Show)

data TextArea = TextArea { tLabel :: String
                         , tName :: String
                         , tRows :: Int
                         , tPlaceholder :: String
                         , tMessage :: String
                         } deriving (Show)
contactTitle :: String
contactTitle = "Contact me"

formItems :: [FormItem]
formItems = [
  FormItem {fLabel="Name", fInput="text", fName="name", fMessage=Just "Please enter your name."},
  FormItem {fLabel="Email address", fInput="email", fName="email", fMessage=Just "Please enter your email address."},
  FormItem {fLabel="Phone number (optional)", fInput="tel", fName="phone", fMessage=Nothing}
  ]

textArea :: TextArea
textArea = TextArea {tLabel="Message", tName="message", tRows=5, tPlaceholder="Enter your message", tMessage="Please enter your message."}

button :: String
button = "Send"

partial :: Content.Homepage -> Html
partial content = $(shamletFile "src/Views/Pages/Home/contact.hamlet")
