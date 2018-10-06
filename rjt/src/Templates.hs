{-# LANGUAGE TemplateHaskell #-}

module Templates where

import About
import Nav
import Text.Hamlet

-- TODO: tidy up all of these template functions
-- Maybe have module for each partial and export only complete partial?

layout :: Html -> Html -> Html -> Html -> Html
layout head nav body footer = $(shamletFile "src/default.hamlet")

template :: String -> Html -> Html
template title content = layout (Templates.head title) navPartial content footer

body :: Html -> Html -> Html
body header about = $(shamletFile "src/body.hamlet")

header :: Html
header = $(shamletFile "src/header.hamlet")

about :: String -> String -> [String] -> Html
about title image paragraphs = $(shamletFile "src/about.hamlet")

head :: String -> Html
head title  = $(shamletFile "src/head.hamlet")

nav :: String -> [NavItem] -> Html
nav brandname items = $(shamletFile "src/nav.hamlet")

footer :: Html
footer = $(shamletFile "src/footer.hamlet")

aboutPage :: Html
aboutPage = about About.title About.image About.paragraphs

navPartial :: Html
navPartial = nav Nav.brandname Nav.items
