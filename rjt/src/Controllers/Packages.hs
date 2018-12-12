{-# LANGUAGE OverloadedStrings #-}

module Controllers.Packages where

import Web.Scotty.Trans as S
import qualified Data.Text.Lazy as L

import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Packages.Packages as PackagesView

renderPackages :: Content -> ActionT L.Text WebM ()
renderPackages content =
  let t = packagesPageTitle $ packagesPage $ content in
  html $ renderHtml $ Layout.app t (PackagesView.partial $ packagesPage content)

packagesController :: ScottyT L.Text WebM ()
packagesController = do
  get "/packages" $ do
    content <- webM $ Internal.gets appContent
    renderPackages content
