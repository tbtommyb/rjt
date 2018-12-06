{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

module Internal where

import Web.Scotty
-- import qualified Data.Text.Lazy as L

import Content (Content)
-- import Control.Applicative (Applicative)
import Control.Monad.Trans.State (StateT)
import Control.Monad.IO.Class (liftIO)
-- import Control.Monad.State.Class (MonadState)
import Control.Monad.State (gets, modify, evalStateT, lift)

import Data.Aeson
import Database.Persist.Sqlite as DB
import qualified Data.ByteString.Lazy as B

data Config = Config
  { getPool :: ConnectionPool
  , appContent :: Content
  } deriving (Show)

type ConfigM = StateT Config ScottyM
type ActionD = StateT Config ActionM
-- newtype ConfigM a = ConfigM
--   { runConfigM :: StateT Config IO a
--   } deriving (Applicative, Functor, Monad, MonadIO, MonadState Config)

runIO :: Config -> ConfigM a -> IO a
runIO c m = evalStateT m c

updateConfig :: Content -> ConfigM ()
updateConfig newContent = do
  modify (\state -> state { appContent = newContent })
  content <- gets appContent
  liftIO $ Internal.writeFile content

writeFile :: Content -> IO ()
writeFile content = B.writeFile "src/config.json" (encode content)
