{-# LANGUAGE OverloadedStrings #-}

module Controllers.Admin where

import Control.Monad
import Control.Monad.Trans.Class (lift)
import Control.Monad.IO.Class
import System.FilePath ((</>))

import Web.Scotty.Trans as S
import Text.Blaze.Html.Renderer.Text
import Network.Wai.Parse

import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Char8 as BS
import qualified Data.Text.Lazy as L

import Internal (gets, webM, appContent, WebM, updateConfig)
import Content
import Views.Admin.EditContent.EditContent as EditContent

renderEditContent :: Content -> ActionT L.Text WebM ()
renderEditContent content = do
  html $ renderHtml $ EditContent.index content

handleContentUpdate :: Content -> WebM ()
handleContentUpdate content = do
  updateConfig content

handleUpload :: String -> FileInfo B.ByteString -> IO ()
handleUpload dir fi = do
  liftIO $ B.writeFile ("src" </> dir </> (BS.unpack (fileName fi))) (fileContent fi)

adminController :: ScottyT L.Text WebM ()
adminController = do
  S.get "/admin" $ do
    content <- webM $ Internal.gets appContent
    renderEditContent content
  S.post "/admin/content" $ do
    jsonContent <- jsonData :: ActionT L.Text WebM (Content)
    lift $ handleContentUpdate jsonContent
    redirect "/admin"
  S.post "/admin/images" $ do
    (_, fi) <- liftM head $ files
    liftIO $ handleUpload "img" fi
    text $ L.pack (BS.unpack (fileName fi))
