{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Templates where

import About
import Nav
import Contact
import Footer
import Testimonials
import Text.Hamlet

-- TODO: tidy up all of these template functions
-- Maybe have module for each partial and export only complete partial?

layout :: Html -> Html -> Html -> Html -> Html
layout head nav body footer = $(shamletFile "src/default.hamlet")

template :: String -> Html -> Html
template title content = layout (Templates.head title) navPartial content footerPartial

home :: Html -> Html -> Html -> Html
home header about contact = $(shamletFile "src/body.hamlet")

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

footer :: String -> [SocialIcon] -> Html
footer title socials = $(shamletFile "src/footer.hamlet")

footerPartial :: Html
footerPartial = footer Footer.title Footer.socials

aboutPartial :: Html
aboutPartial = about About.title About.image About.paragraphs About.videoParagraphs About.youtubeSlug

contactPartial :: Html
contactPartial = contact Contact.title Contact.formItems Contact.button

navPartial :: Html
navPartial = nav Nav.brandname Nav.items

singlePartial :: String -> Html -> Html
singlePartial title content = $(shamletFile "src/single.hamlet")

testimonials :: String -> [Testimonial] -> Html
testimonials title testimonials = $(shamletFile "src/testimonials.hamlet")

testimonialsPartial :: String -> Html
testimonialsPartial title = Templates.testimonials title Testimonials.testimonials
