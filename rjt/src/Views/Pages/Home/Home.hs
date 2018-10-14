{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.Home where

import Text.Hamlet

import qualified Views.Partials.Header as Header (partial)
import qualified Views.Pages.Home.About as About (partial)
import qualified Views.Pages.Home.Contact as Contact (partial)

home :: Html -> Html -> Html -> Html
home header about contact = $(shamletFile "src/Views/Pages/Home/body.hamlet")

partial :: Html
partial = home Header.partial About.partial Contact.partial
