{-# LANGUAGE TemplateHaskell #-}

module Views.Admin.Users.Users where

import Data.Int

import Database.Persist()
import Database.Persist.Sqlite
import Text.Hamlet

import Internal
import Database
import Views.Layout as Layout
import Models.User as UserModel

index :: ConfigM (Html)
index = do
  users <- UserModel.getAll
  pure $ Layout.admin "Users (admin)" $ Layout.single "Users" $(shamletFile "src/Views/Admin/Users/index.hamlet")

show :: Int64 -> ConfigM (Html)
show userId = do
  user <- UserModel.getById userId
  pure $ Layout.admin "User (admin" $ Layout.single (userName user) $(shamletFile "src/Views/Admin/Users/single.hamlet")