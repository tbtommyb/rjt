{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.Home where

import qualified Views.Partials.Header as Header (partial)
import qualified Views.Pages.Home.About as About (partial)
import qualified Views.Pages.Home.Contact as Contact (partial)
import Text.Hamlet

partial :: Html
partial = $(shamletFile "src/Views/Pages/Home/body.hamlet")
