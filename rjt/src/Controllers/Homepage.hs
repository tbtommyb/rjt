{-# LANGUAGE OverloadedStrings #-}

module Controllers.Homepage where

import Control.Monad.State (gets, lift, runStateT, execStateT, evalStateT)
import qualified Data.Text.Lazy as L

import Web.Scotty (ScottyM)
import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Home.Home as HomeView

renderHomepage :: Content -> ActionT L.Text WebM ()
renderHomepage content =
  let t = tabTitle $ homePage $ content in
  html $ renderHtml $ Layout.app t (HomeView.partial $ homePage content)

-- homepageController :: ConfigM (ScottyT L.Text ConfigM ())
-- homepageController :: ConfigM ()
-- homepageController = do
--   content <- gets appContent
--   lift $ S.get "/" $ renderHomepage content
--     -- S.get "/index.html" $ renderHomepage content

homepageController :: ScottyT L.Text WebM()
homepageController = do
  S.get "/" $ do
    content <- webM $ Internal.gets appContent
    renderHomepage content
  -- S.get "/" $ evalStateT renderHomepage config
  -- S.get "/index" $ evalStateT renderHomepage config
