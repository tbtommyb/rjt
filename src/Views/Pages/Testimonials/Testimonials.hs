{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Testimonials.Testimonials where

import qualified Data.Text.Lazy as L
import Text.Hamlet
import Text.Markdown

import Content

partial :: Content.TestimonialsPage -> Html
partial content = $(shamletFile "src/Views/Pages/Testimonials/testimonials.hamlet")
