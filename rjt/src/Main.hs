{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

import qualified Web.Scotty ()
import Web.Scotty.Trans as S

import Control.Applicative (Applicative)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.Reader.Class (MonadReader)
import Control.Monad.IO.Class (liftIO, MonadIO)

-- import Config
-- import Data.Maybe
-- import Data.Aeson
-- import qualified Data.ByteString.Lazy as B
import qualified Data.Text.Lazy as T
import Text.Markdown
import System.FilePath
import Text.Blaze.Html.Renderer.Text

import Database as DB
import Internal

import Models.User as User

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

main :: IO ()
main = do
  pool <- DB.setup "dev.db" 3
  let config = Config { getPool = pool }
  scottyT 4000 (runIO config) =<< runIO config application

-- Main application
application :: ConfigM (ScottyT T.Text ConfigM ())
application = do
    return $ do
      S.get "/users" $ do
        users <- lift $ User.getAll
        html $ T.pack $ show $ length(users)
      S.get "/" $ renderHomepage
      S.get "/index.html" $ renderHomepage
      S.get "/packages" $ renderPackages
      S.get "/testimonials" $ renderTestimonials
      S.get "/videos" $ renderVideos
      -- TODO: maybe replace with middleware
      S.get "/:dirname/:filename" $ do
        dirname <- param "dirname"
        filename <- param "filename"
        file $ "src" </> dirname </> filename
