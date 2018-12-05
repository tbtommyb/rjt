{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Views.Pages.Home.About where

import qualified Data.Text.Lazy as L
import Text.Markdown
import Text.Hamlet
import Content

partial :: Content.Homepage -> Html
partial content = $(shamletFile "src/Views/Pages/Home/about.hamlet")
