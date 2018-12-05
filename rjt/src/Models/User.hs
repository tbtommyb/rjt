-- {-# LANGUAGE FlexibleContexts #-}

module Models.User where

-- import Data.Int
-- import Control.Monad.Trans.State (StateT)

-- import Database.Persist()
-- import Database.Persist.Sqlite

-- import Internal
-- import Database as DB

-- getAll :: ConfigM [Entity DB.User]
-- getAll = do
--   DB.runDb (selectList [] [])

-- getById :: Int64 -> ConfigM DB.User
-- getById userId = do
--   maybeUser <- DB.runDb $ get (toSqlKey userId) ::ConfigM (Maybe DB.User)
--   case maybeUser of
--     Nothing -> pure $ User "I" "don't" "exist" -- TODO: handle better
--     Just user -> pure user

-- create :: String -> String -> String -> ConfigM (Key User)
-- create first second email = do
--   DB.runDb $ insert $ User first second email
