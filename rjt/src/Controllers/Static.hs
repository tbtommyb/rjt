{-# LANGUAGE OverloadedStrings #-}

module Controllers.Static where

import qualified Data.Text.Lazy as L
import Web.Scotty.Trans as S
import System.FilePath

import Internal

staticController :: ScottyT L.Text WebM ()
staticController = do
  get "/:dirname/:filename" $ do
    dirname <- param "dirname"
    filename <- param "filename"
    file $ "src" </> dirname </> filename
