{-# LANGUAGE OverloadedStrings #-}

module Controllers.Testimonials where

import Web.Scotty.Trans as S
import qualified Data.Text.Lazy as L

import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Testimonials.Testimonials as TestimonialsView

renderTestimonials :: Content -> ActionT L.Text WebM ()
renderTestimonials content =
  let t = testimonialsPageTitle $ testimonialsPage $ content in
  html $ renderHtml $ Layout.app t (TestimonialsView.partial $ testimonialsPage content)

testimonialsController :: ScottyT L.Text WebM ()
testimonialsController = do
  get "/testimonials" $ do
    content <- webM $ Internal.gets appContent
    renderTestimonials content
