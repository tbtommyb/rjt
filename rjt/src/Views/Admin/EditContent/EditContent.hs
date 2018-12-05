{-# LANGUAGE TemplateHaskell #-}

module Views.Admin.EditContent.EditContent where

import Internal
import Content
import Views.Layout as Layout
import Text.Hamlet

index :: Content -> IO (Html)
index content = do
  pure $ Layout.admin "Adminzz" $ Layout.single "Edit Content" $(shamletFile "src/Views/Admin/EditContent/index.hamlet")
