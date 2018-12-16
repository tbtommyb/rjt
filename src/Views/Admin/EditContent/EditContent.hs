{-# LANGUAGE TemplateHaskell #-}

module Views.Admin.EditContent.EditContent where

import Content
import Views.Layout as Layout
import Text.Hamlet

partial :: Content -> Html
partial content = $(shamletFile "src/Views/Admin/EditContent/index.hamlet")
