module Views.Pages.Packages.Packages where

import Views.Layout as Layout
import Data.Text.Lazy
import Text.Hamlet
import Text.Markdown
import Control.Monad.IO.Class (liftIO)

partial :: String -> Html
partial title = do
  packages <- liftIO $ readFile "src/packages.md"
  Layout.single title $ markdown def $ pack packages
