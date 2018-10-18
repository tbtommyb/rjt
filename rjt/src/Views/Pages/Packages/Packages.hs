module Views.Pages.Packages.Packages where

import Views.Layout as Layout
import Data.Text.Lazy
import Text.Hamlet
import Text.Markdown

partial :: String -> IO Html
partial title = do
  packages <- readFile "src/packages.md"
  return $ Layout.single title $ markdown def $ pack packages
