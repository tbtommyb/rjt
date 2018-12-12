{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

module Internal where

import Control.Concurrent.STM
import Control.Monad.Reader
import Data.Aeson
import qualified Data.ByteString.Lazy as B

import Content (Content)

data Config = Config
  { appContent :: Content
  } deriving (Show)

newtype WebM a = WebM { runWebM :: ReaderT (TVar Config) IO a }
  deriving (Applicative, Functor, Monad, MonadIO, MonadReader (TVar Config))

webM :: MonadTrans t => WebM a -> t WebM a
webM = lift

gets :: (Config -> b) -> WebM b
gets f = ask >>= liftIO . readTVarIO >>= return . f

modify :: (Config -> Config) -> WebM ()
modify f = ask >>= liftIO . atomically . flip modifyTVar' f

writeFile :: Content -> IO ()
writeFile content = B.writeFile "src/config.json" (encode content)

updateConfig :: Content -> WebM ()
updateConfig newContent = do
  modify (\state -> state { appContent = newContent })
  content <- gets appContent
  liftIO $ Internal.writeFile content
