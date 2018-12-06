{-# LANGUAGE OverloadedStrings #-}

module Controllers.Admin where

import Control.Monad.State (gets, evalStateT)
import Control.Monad.Trans.Class (lift)
import qualified Data.Text.Lazy as L

import Web.Scotty (ScottyM)
import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text

import Internal
import Content
import Views.Admin.EditContent.EditContent as EditContent

-- renderEditContent :: Content -> ActionT L.Text ConfigM ()
-- renderEditContent content = do
--   lift (EditContent.index content) >>= html . renderHtml

renderEditContent :: ActionD ()
renderEditContent = do
  content <- gets appContent
  lift $ html $ renderHtml $ EditContent.index content

handleContentUpdate :: ActionD ()
handleContentUpdate = do
  jsonContent <- jsonData :: ActionT L.Text ConfigM Content
  lift $ Internal.updateConfig jsonContent
-- handleContentUpdate :: ActionT L.Text IO ()
-- handleContentUpdate = do
--   jsonContent <- jsonData :: ActionT L.Text ConfigM Content
--   lift $ Internal.updateConfig jsonContent

-- adminController :: ConfigM (ScottyT L.Text ConfigM ())
-- adminController = do
--   content <- gets appContent
--   pure $ do
--     S.get "/admin" $ renderEditContent content
--     -- S.post "/admin/content" $ handleContentUpdate

adminController :: Config -> ScottyM ()
adminController config = do
  S.get "/admin" $ evalStateT renderEditContent config
  S.post "/admin/content" $ evalStateT handleContentUpdate config
