{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import qualified Web.Scotty ()
import Web.Scotty.Trans as S

import Data.Pool ()
import Database.Persist.Sqlite as DB

import Control.Applicative (Applicative)
import Control.Monad.Trans.Class (MonadTrans, lift)
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Monad.Reader.Class (MonadReader)
import Control.Monad.Reader (asks)
import Control.Monad.Logger (runStdoutLoggingT)

-- import Config
-- import Data.Maybe
-- import Data.Aeson
-- import qualified Data.ByteString.Lazy as B
import qualified Data.Text.Lazy as T
import Text.Markdown
import System.FilePath
import Text.Blaze.Html.Renderer.Text

import Model

import Views.Layout as Layout
import Views.Pages.Home.Home as Home
import Views.Pages.Packages.Packages as Packages
import Views.Pages.Testimonials.Testimonials as Testimonials
import Views.Pages.Videos.Videos as Videos

renderHomepage :: ActionT T.Text ConfigM ()
renderHomepage = html $ renderHtml $ Layout.app "RJ Transformations" Home.partial

renderPackages :: ActionT T.Text ConfigM ()
renderPackages = do
  content <- liftIO $ Packages.partial "Packages"
  html $ renderHtml $ Layout.app "Packages" content

renderTestimonials :: ActionT T.Text ConfigM ()
renderTestimonials = html $ renderHtml $ Layout.app "Testimonials" $ Layout.single "Testimonials" Testimonials.partial

renderVideos :: ActionT T.Text ConfigM ()
renderVideos = do
  videoContent <- liftIO $ readFile "src/videos.md"
  html $ renderHtml $ Layout.app "Videos" $ Layout.single "Videos" $ Videos.partial $ markdown def $ T.pack videoContent

data Config = Config { getPool :: ConnectionPool }

newtype ConfigM a = ConfigM
    { runConfigM :: ReaderT Config IO a
    } deriving (Applicative, Functor, Monad,
                MonadIO, MonadReader Config)

-- config <- B.readFile "src/config.json"
-- let cfg = decode config :: Maybe Config.Config

runIO :: Config -> ConfigM a -> IO a
runIO c m = runReaderT (runConfigM m) c

main :: IO ()
main = do
    pool <- runStdoutLoggingT $ createSqlitePool "dev.db" 3
    let cfg = Config { getPool = pool }
    application <- runIO cfg Main.app
    scottyT 4000 (runIO cfg) application

-- insertUsers :: ReaderT SqlBackend IO ()
-- insertUsers = do
--   _ <- insert $ User "Tom" $ "Johnson" $ "tom@tmjohson.co.uk"
--   _ <- insert $ User "Roland" $ "Johnson" $ "roland@rjtransformations.co.uk"

runDb :: (MonadTrans t, MonadIO (t ConfigM)) => SqlPersistT IO a -> t ConfigM a
runDb query = do
    pool <- lift $ asks getPool
    liftIO (runSqlPool query pool)

runMigrations :: ReaderT SqlBackend IO ()
runMigrations = runMigration migrateAll

getUsers :: ActionT T.Text ConfigM ()
getUsers = do
    users <- runDb (selectList [] [])
    html $ T.pack (show (length (users :: [Entity User])))

app :: ConfigM (ScottyT T.Text ConfigM ())
app = do
  return $ do
    runDb runMigrations
    -- runDb insertUsers
  return $ do
    S.get "/hello" $ (html "hello")
    S.get "/world" $ (html "world")
    -- S.get "/" $ renderHomepage
    -- S.get "/index.html" $ renderHomepage
    -- S.get "/packages" $ renderPackages
    -- S.get "/testimonials" $ renderTestimonials
    -- S.get "/videos" $ renderVideos
    -- -- TODO: maybe replace with middleware
    -- S.get "/:dirname/:filename" $ do
    --   dirname <- param "dirname"
    --   filename <- param "filename"
    --   file $ "src" </> dirname </> filename
