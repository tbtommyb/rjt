{-# LANGUAGE RankNTypes                 #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}

module Database where

import Control.Monad.Reader.Class (MonadReader)
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Monad.Reader (asks)

import Data.Text
import Data.Pool (Pool)
import Database.Persist()
import Database.Persist.TH
import Database.Persist.Sqlite
import Control.Monad.Logger (runStdoutLoggingT)

import Internal (Config, getPool)

runDb :: (MonadReader Config m, MonadIO m) => SqlPersistT IO a -> m a
runDb query = do
    pool <- asks getPool
    liftIO $ runSqlPool query pool

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
    name String
    surname String
    email String
    deriving Show
|]

setup :: Text -> Int -> IO (Pool SqlBackend)
setup dbName connCount = do
  pool <- runStdoutLoggingT $ createSqlitePool dbName connCount
  runSqlPool (runMigration migrateAll) pool
  pure $ pool
