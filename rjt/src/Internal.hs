{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Internal where

import Content (Content)
import Control.Applicative (Applicative)
import Control.Monad.Trans.State (StateT, runStateT, evalStateT)
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.State.Class (MonadState)

import Database.Persist.Sqlite as DB

data Config = Config
  { getPool :: ConnectionPool
  , appContent :: Content
  } deriving (Show)

newtype ConfigM a = ConfigM
  { runConfigM :: StateT Config IO a
  } deriving (Applicative, Functor, Monad, MonadIO, MonadState Config)

runIO :: Config -> ConfigM a -> IO a
runIO c m = evalStateT (runConfigM m) c
