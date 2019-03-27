module Constr (File(..)) where

import qualified Data.Text as T

data File = File
  { name :: FilePath
  , content :: T.Text
  } deriving (Show)

