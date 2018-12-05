{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

module Internal where

import Web.Scotty.Trans as S
import qualified Data.Text.Lazy as L

import Content (Content)
import Control.Applicative (Applicative)
import Control.Monad.Trans.State (StateT, evalStateT)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.State.Class (MonadState)
-- import Control.Monad.State (gets, modify)

-- import Data.Aeson
import Database.Persist.Sqlite as DB
-- import qualified Data.ByteString.Lazy as B

data Config = Config
  { getPool :: ConnectionPool
  , appContent :: Content
  } deriving (Show)

newtype ConfigM a = ConfigM
  { runConfigM :: StateT Config IO a
  } deriving (Applicative, Functor, Monad, MonadIO, MonadState Config)

runIO :: Config -> ConfigM a -> IO a
runIO c m = evalStateT (runConfigM m) c

-- updateConfig :: Content -> ConfigM ()
-- updateConfig newContent = do
--   modify (\state -> state { appContent = newContent })
--   content <- gets appContent
--   liftIO $ B.writeFile "src/config.json" (encode content)
