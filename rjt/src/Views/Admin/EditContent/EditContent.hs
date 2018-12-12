{-# LANGUAGE TemplateHaskell #-}

module Views.Admin.EditContent.EditContent where

import Content
import Views.Layout as Layout
import Text.Hamlet

index :: Content -> Html
index content =
  Layout.admin "Admin" $ Layout.single "Edit Content" $(shamletFile "src/Views/Admin/EditContent/index.hamlet")
