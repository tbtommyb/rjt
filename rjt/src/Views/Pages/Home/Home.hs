{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.Home where

import qualified Views.Partials.Header as Header (partial)
import Views.Pages.Home.About as About
import Views.Pages.Home.Contact as Contact
import Text.Hamlet

home :: Html -> Html -> Html -> Html
home header about contact = $(shamletFile "src/Views/Pages/Home/body.hamlet")

partial :: Html
partial = home Header.partial About.aboutPartial Contact.contactPartial
