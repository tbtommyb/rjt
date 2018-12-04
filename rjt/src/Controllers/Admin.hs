{-# LANGUAGE OverloadedStrings #-}

module Controllers.Admin where

import Control.Monad.Trans.Class (lift)
import qualified Data.Text.Lazy as L

import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Admin.EditContent.EditContent as EditContent

renderEditContent :: Content -> ActionT L.Text ConfigM ()
renderEditContent content = do
  lift (EditContent.index content) >>= html . renderHtml

adminController :: Content -> ScottyT L.Text ConfigM ()
adminController content = do
  S.get "/admin" $ renderEditContent content
