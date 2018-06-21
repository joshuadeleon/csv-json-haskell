module Main where

import CommandOptions
import Control.Monad
import qualified Data.Aeson as A
import qualified Data.ByteString.Lazy as BL
import Options.Applicative
import Person

main :: IO ()
main = do
  args <- execParser argumentHelper -- handles command line arguments
  csvData <- decodeCsv $ csv args
  let persons = getPersons csvData
  let personsJson = A.encode persons
  BL.writeFile (json args) personsJson
