{-# LANGUAGE OverloadedStrings #-}

module Controllers.Videos where

import Web.Scotty.Trans as S
import qualified Data.Text.Lazy as L

import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Videos.Videos as VideosView

renderVideos :: Content -> ActionT L.Text WebM ()
renderVideos content =
  let t = videosPageTitle $ videosPage $ content in
  html $ renderHtml $ Layout.app t (VideosView.partial $ videosPage content)

videosController :: ScottyT L.Text WebM ()
videosController = do
  get "/videos" $ do
    content <- webM $ Internal.gets appContent
    renderVideos content
