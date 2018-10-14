{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Views.Layout where

import Views.Partials.Head as Head
import Views.Partials.Nav as Nav
import Views.Partials.Footer as Footer
import Text.Hamlet

appBuilder :: Html -> Html -> Html -> Html -> Html
appBuilder head nav body footer = $(shamletFile "src/Views/layout.hamlet")

app :: String -> Html -> Html
app title content = appBuilder (Head.partial title) Nav.partial content Footer.partial

single :: String -> Html -> Html
single title content = $(shamletFile "src/Views/single.hamlet")
