module Main where

import Control.Monad
import qualified Data.Aeson as A
import qualified Data.ByteString.Lazy as BL
import Person

personCSV :: String
personCSV = "./mock/MOCK_DATA.csv"

jsonFilePath :: String
jsonFilePath = "./mock/Json_Mock.json"

writeJson :: BL.ByteString -> IO ()
writeJson = BL.writeFile jsonFilePath

main :: IO ()
main = do
  csvData <- decodeCsv personCSV
  let persons = getPersons csvData
  let personsJson = A.encode persons
  writeJson personsJson
