{-# LANGUAGE OverloadedStrings #-}

module Controllers.Homepage where

import Web.Scotty.Trans as S
import qualified Data.Text.Lazy as L
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Home.Home as HomeView

renderHomepage :: Content -> ActionT L.Text WebM ()
renderHomepage content =
  let t = tabTitle $ homePage $ content in
  html $ renderHtml $ Layout.app t (HomeView.partial $ homePage content)

homepageController :: ScottyT L.Text WebM()
homepageController = do
  S.get "/" $ do
    content <- webM $ Internal.gets appContent
    renderHomepage content
