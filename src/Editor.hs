module Editor (
    Editor
  , focusedBuf
  , focused
  , buffers
  , exiting
) where

import Control.Lens
import Data.Default (def, Default(..))

import Buffer

data Editor = Editor {
    _buffers :: [Buffer Offset]
  , _focused :: Int
  , _exiting :: Bool
}

makeLenses ''Editor

instance Default Editor where
    def = Editor {
            _buffers=fmap buffer [ ("Buf0.txt", "Buffer 0\nHey! How's it going over there?\nI'm having just a splended time!\nAnother line for you sir?")
                                 , ("Buf1.txt", "Buffer 1\nHey! How's it going over there?\nI'm having just a splended time!\nAnother line for you sir?") ]
          , _focused=0
          , _exiting=False
             }


focusedBuf :: Lens' Editor (Buffer Offset)
focusedBuf = lens getter (flip setter)
    where getter = do
            foc <- view focused
            -- TODO use ix here and make it safe??
            view (buffers.to (!! foc))

          setter a = do
            foc <- view focused
            set (buffers . ix foc) a

