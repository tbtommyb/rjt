{-# LANGUAGE FlexibleContexts #-}

module Models.User where

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
