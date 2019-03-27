{-# LANGUAGE BlockArguments    #-}
{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( start
  ) where

import           Codec.Archive.Zip
import           Constr                 (File (..))
import qualified Data.ByteString.Char8  as C8
import qualified Data.Text              as T
import           Files
import           System.Environment     (getArgs)
import           System.FilePath        (joinPath)
import           System.FilePath.Posix  ((</>))

srcDir :: FilePath
srcDir = "src"

replaceContents :: T.Text -> T.Text -> T.Text
replaceContents = T.replace "{{name}}"

updateContent :: T.Text -> File -> File
updateContent dest f@File {content} = f {content = replaceContents dest content}

updateFileContents :: T.Text -> [File]
updateFileContents new = map (updateContent new) _files

insertUnderSrc :: FilePath -> FilePath
insertUnderSrc path = joinPath [srcDir, path]

addFile :: File -> ZipArchive ()
addFile File {content, name} = mkEntrySelector name >>= addEntry Store (C8.pack $ T.unpack content)

start :: IO ()
start = do
  [projectName] <- getArgs
  -- replacing the placeholders with the project name
  let updatedFiles = updateFileContents $ T.pack projectName
  let outFile = projectName <> ".zip"
  putStrLn "Adding files to archive..."
  createArchive outFile do
    -- adding the current "src" directory
    packDirRecur Store (mkEntrySelector . insertUnderSrc) srcDir
    -- adding the netbeans config files
    traverse addFile updatedFiles
  putStrLn "Done!"
