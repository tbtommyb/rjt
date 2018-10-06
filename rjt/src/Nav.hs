module Nav where

data NavItem = NavItem { name :: String
                       , url :: String
                       , weighting :: Int
                       } deriving (Show)

items :: [NavItem]
items = [
  NavItem {name="About", url="/index.html#about", weighting=1},
  NavItem {name="Packages", url="/packages", weighting=2},
  NavItem {name="Testimonials", url="/testimonials", weighting=3},
  NavItem {name="Videos", url="/videos", weighting=4},
  NavItem {name="Contact", url="/index.html#contact", weighting=5},
  NavItem {name="Blog", url="https://medium.com/@rolandjohnson_75946", weighting=6}
  ]

brandname :: String
brandname = "RJ TRANSFORMATIONS"
