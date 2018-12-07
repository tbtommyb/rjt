{-# LANGUAGE OverloadedStrings #-}

module Controllers.Admin where

import Control.Monad.Trans.Class (lift)
import qualified Data.Text.Lazy as L
import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal (gets, webM, appContent, WebM, updateConfig)
import Content
import Views.Admin.EditContent.EditContent as EditContent

renderEditContent :: Content -> ActionT L.Text WebM ()
renderEditContent content = do
  html $ renderHtml $ EditContent.index content

handleContentUpdate :: Content -> WebM ()
handleContentUpdate content = do
  updateConfig content

adminController :: ScottyT L.Text WebM ()
adminController = do
  S.get "/admin" $ do
    content <- webM $ Internal.gets appContent
    renderEditContent content
  S.post "/admin/content" $ do
    jsonContent <- jsonData :: ActionT L.Text WebM (Content)
    lift $ handleContentUpdate jsonContent
    redirect "/admin"
