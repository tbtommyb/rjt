{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Controllers.Homepage where

import Control.Monad.Trans.Class (lift)
import Control.Monad.Reader (asks)

import qualified Data.Text.Lazy as L
import qualified Data.Text as T

import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Layout as Layout
import Views.Pages.Home.Home as HomeView

renderHomepage :: Content.Homepage -> ActionT L.Text ConfigM ()
renderHomepage content = do
  let t = T.unpack $ title $ content
  html $ renderHtml $ Layout.app t HomeView.partial

homepageController :: Content.Homepage -> ScottyT L.Text ConfigM ()
homepageController content = do
  S.get "/" $ renderHomepage content
  S.get "/index.html" $ renderHomepage content
