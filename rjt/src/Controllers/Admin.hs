{-# LANGUAGE OverloadedStrings #-}

module Controllers.Admin where

import Control.Monad.State (gets)
import Control.Monad.Trans.Class (lift)
import qualified Data.Text.Lazy as L

import Web.Scotty (ScottyM)
import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Admin.EditContent.EditContent as EditContent

renderEditContent :: Content -> ActionT L.Text IO ()
renderEditContent content = do
  lift (EditContent.index content) >>= html . renderHtml

-- handleContentUpdate :: ActionT L.Text IO ()
-- handleContentUpdate = do
--   jsonContent <- jsonData :: ActionT L.Text ConfigM Content
--   lift $ Internal.updateConfig jsonContent

adminController :: ConfigM (ScottyT L.Text IO ())
adminController = do
  content <- gets appContent
  pure $ do
    S.get "/admin" $ renderEditContent content
    -- S.post "/admin/content" $ handleContentUpdate
