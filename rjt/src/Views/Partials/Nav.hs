{-# LANGUAGE TemplateHaskell #-}

module Views.Partials.Nav where

import Text.Hamlet

data NavItem = NavItem { name :: String
                       , url :: String
                       , weighting :: Int
                       } deriving (Show)

publicItems :: [NavItem]
publicItems = [
  NavItem {name="About", url="/index.html#about", weighting=1},
  NavItem {name="Packages", url="/packages", weighting=2},
  NavItem {name="Testimonials", url="/testimonials", weighting=3},
  NavItem {name="Videos", url="/videos", weighting=4},
  NavItem {name="Contact", url="/index.html#contact", weighting=5},
  NavItem {name="Blog", url="https://medium.com/@rolandjohnson_75946", weighting=6}
  ]

adminItems :: [NavItem]
adminItems = NavItem {name="Admin", url="/admin", weighting=7} : publicItems

brandname :: String
brandname = "RJ TRANSFORMATIONS"

partial :: Html
partial =
  let items = publicItems
  in $(shamletFile "src/Views/Partials/nav.hamlet")

admin :: Html
admin =
  let items = adminItems
  in $(shamletFile "src/Views/Partials/nav.hamlet")
