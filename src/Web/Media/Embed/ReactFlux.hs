{-# LANGUAGE CPP               #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Web.Media.Embed.ReactFlux (
    renderYoutube
  , simpleRenderYoutube
) where



import           Data.Text          (Text)
import qualified Data.Text          as Text
import           React.Flux

import           Web.Media.Embed



#ifdef __GHCJS__
import           Data.JSString      (JSString)
import qualified Data.JSString.Text as JSS (textToJSString)
#else
type JSString = String
#endif



#ifdef __GHCJS__
textToJSString' :: Text -> JSString
textToJSString' = JSS.textToJSString
#else
textToJSString' :: Text -> String
textToJSString' = Text.unpack
#endif



type HTMLView_ = ReactElementM ViewEventHandler ()



renderYoutube :: YoutubeEmbed -> HTMLView_
renderYoutube youtube_embed@YoutubeEmbed{..} = do
  iframe_ [ "src"          $= textToJSString' iframeSrc
          , "height"       @= iframeHeight
          , "width"        @= iframeWidth
          , "frameboarder" @= iframeBoarder
          ] mempty
  where
  IFrame{..} = youtubeEmbedToIFrame youtube_embed defaultIFrame



simpleRenderYoutube :: Text -> IFrame -> HTMLView_
simpleRenderYoutube url iframe = do
  iframe_ [ "src"          $= textToJSString' iframeSrc
          , "height"       @= iframeHeight
          , "width"        @= iframeWidth
          , "frameboarder" @= iframeBoarder
          ] mempty
  where
  IFrame{..} = simpleYoutubeEmbedToIFrame url iframe
