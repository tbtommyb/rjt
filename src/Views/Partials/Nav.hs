{-# LANGUAGE TemplateHaskell #-}

module Views.Partials.Nav where

import Text.Hamlet

data NavItem = NavItem { name :: String
                       , url :: String
                       , weighting :: Int
                       } deriving (Show)

publicItems :: [NavItem]
publicItems = [
  NavItem {name="About", url="/#about", weighting=1},
  NavItem {name="Packages", url="/packages", weighting=2},
  NavItem {name="Testimonials", url="/testimonials", weighting=3},
  NavItem {name="Videos", url="/videos", weighting=4},
  NavItem {name="Contact", url="/#contact", weighting=5},
  NavItem {name="Blog", url="https://medium.com/@rolandjohnson_75946", weighting=6}
  ]

brandname :: String
brandname = "RJ TRANSFORMATIONS"

partial :: Html
partial =
  let items = publicItems
  in $(shamletFile "src/Views/Partials/nav.hamlet")
