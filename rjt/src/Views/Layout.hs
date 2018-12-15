{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Views.Layout where

import Views.Partials.Head as Head
import Views.Partials.Nav as Nav
import Views.Partials.Footer as Footer (partial)
import Text.Hamlet

appBuilder :: Html -> Html -> Html -> Html -> Html
appBuilder head nav body footer = $(shamletFile "src/Views/layout.hamlet")

adminBuilder :: Html -> Html -> Html -> Html -> Html
adminBuilder head nav body footer = $(shamletFile "src/Views/admin.hamlet")

app :: String -> Html -> Html
app title content = appBuilder (Head.partial title) Nav.partial content Footer.partial

admin :: String -> Html -> Html
admin title content = adminBuilder (Head.partial title) Nav.partial content Footer.partial
