module Main where

import Control.Monad
import qualified Data.Aeson as A
import qualified Data.ByteString.Lazy as BL
import qualified Data.Csv as C
import qualified Data.Text as T
import qualified Data.Vector as V
import GHC.Generics

-- import Control.Applicative
-- | Represents a person CSV file
data Person = Person
  { id :: Int
  , first_name :: T.Text
  , last_name :: T.Text
  , email :: T.Text
  , gender :: T.Text
  } deriving (Generic, Show)

instance C.FromNamedRecord Person where
  parseNamedRecord row =
    Person <$> C.lookup row "id" <*> C.lookup row "first_name" <*>
    C.lookup row "last_name" <*>
    C.lookup row "email" <*>
    C.lookup row "gender"

instance A.ToJSON Person

instance A.FromJSON Person

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

-- | Decodes a CSV into a Person
decodeCsv :: String -> IO (Either String (C.Header, V.Vector Person))
decodeCsv filePath = C.decodeByName <$> BL.readFile filePath

-- | Gets Persons from an Either
getPersons :: Either String (C.Header, V.Vector a) -> V.Vector a
getPersons (Right (_, v)) = v
