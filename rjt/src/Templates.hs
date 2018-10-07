{-# LANGUAGE TemplateHaskell #-}

module Templates where

import About
import Nav
import Contact
import Text.Hamlet

-- TODO: tidy up all of these template functions
-- Maybe have module for each partial and export only complete partial?

layout :: Html -> Html -> Html -> Html -> Html
layout head nav body footer = $(shamletFile "src/default.hamlet")

template :: String -> Html -> Html
template title content = layout (Templates.head title) navPartial content footer

body :: Html -> Html -> Html -> Html
body header about contact = $(shamletFile "src/body.hamlet")

header :: Html
header = $(shamletFile "src/header.hamlet")

-- TODO: need a better way of handling sets of paragraphs
about :: String -> String -> [String] -> [String] -> String -> Html
about title image paragraphs videoParagraphs youtubeSlug = $(shamletFile "src/about.hamlet")

head :: String -> Html
head title  = $(shamletFile "src/head.hamlet")

nav :: String -> [NavItem] -> Html
nav brandname items = $(shamletFile "src/nav.hamlet")

contact :: String -> [FormItem] -> String -> Html
contact title formItems button = $(shamletFile "src/contact.hamlet")

footer :: Html
footer = $(shamletFile "src/footer.hamlet")

aboutPartial :: Html
aboutPartial = about About.title About.image About.paragraphs About.videoParagraphs About.youtubeSlug

contactPartial :: Html
contactPartial = contact Contact.title Contact.formItems Contact.button

navPartial :: Html
navPartial = nav Nav.brandname Nav.items
