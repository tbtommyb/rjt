{-# LANGUAGE OverloadedStrings #-}

module Controllers.Homepage where

import qualified Data.Text.Lazy as L

import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Home.Home as HomeView

renderHomepage :: Content -> ActionT L.Text ConfigM ()
renderHomepage content = do
  let t = tabTitle $ homePage $ content
  html $ renderHtml $ Layout.app t (HomeView.partial $ homePage content)

homepageController :: Content -> ScottyT L.Text ConfigM ()
homepageController content = do
  S.get "/" $ renderHomepage content
  S.get "/index.html" $ renderHomepage content
