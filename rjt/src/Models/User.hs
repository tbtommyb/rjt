{-# LANGUAGE FlexibleContexts #-}

module Models.User where

import Data.Int
import Control.Monad.Trans.Reader (ReaderT)

import Database.Persist()
import Database.Persist.Sqlite

import Internal
import Database as DB

-- DB stuff to be moved out
insertUsers :: ReaderT SqlBackend IO ()
insertUsers = do
  _ <- insert $ User "Tom" "Johnson" "tom@tmjohson.co.uk"
  _ <- insert $ User "Roland" "Johnson" "roland@rjtransformations.co.uk"
  return ()

getAll :: ConfigM [Entity DB.User]
getAll = do
  DB.runDb (selectList [] [])

getById :: Int64 -> ConfigM DB.User
getById userId = do
  maybeUser <- DB.runDb $ get (toSqlKey userId) ::ConfigM (Maybe DB.User)
  case maybeUser of
    Nothing -> pure $ User "I" "don't" "exist" -- TODO: handle better
    Just user -> pure user
