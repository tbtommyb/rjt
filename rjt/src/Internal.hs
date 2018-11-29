{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Internal where

import Content (Content)
import Control.Applicative (Applicative)
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Reader.Class (MonadReader)

import Database.Persist.Sqlite as DB

data Config = Config
  { getPool :: ConnectionPool
  , getContent :: Content
  } deriving (Show)

newtype ConfigM a = ConfigM
  { runConfigM :: ReaderT Config IO a
  } deriving (Applicative, Functor, Monad, MonadIO, MonadReader Config)

runIO :: Config -> ConfigM a -> IO a
runIO c m = runReaderT (runConfigM m) c
