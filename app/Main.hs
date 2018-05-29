module Main where

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Text as T
import qualified Data.Vector as V

-- import Control.Applicative
-- | Represents a person CSV file
data Person = Person
  { id :: Int
  , first_name :: T.Text
  , last_name :: T.Text
  , email :: T.Text
  , gender :: T.Text
  } deriving (Show)

instance FromNamedRecord Person where
  parseNamedRecord row =
    Person <$> row .: "id" <*> row .: "first_name" <*> row .: "last_name" <*>
    row .: "email" <*>
    row .: "gender"

personCSV :: String
personCSV =
  "/Users/deleonj/OneDrive - autodesk/Personal/code/csv-json-haskell/mock/MOCK_DATA.csv"

--readPersonCSV :: ByteString -> Vector Person
main :: IO ()
main = do
  csvData <- decodeCsv personCSV
  let persons = getPersons csvData
  print $ V.head persons
  -- let p = head $ getPersons csv
  -- print p
  -- case decodeByName csvData of
  --   Left err -> putStrLn err
  --   Right (_, v) ->
  --     V.forM_ v (\p -> print $ T.concat [first_name p, " ", last_name p])

-- | Decodes a CSV into a Person
decodeCsv :: String -> IO (Either String (Header, V.Vector Person))
decodeCsv filePath = decodeByName <$> BL.readFile filePath

getPersons :: Either String (Header, V.Vector a) -> V.Vector a
getPersons (Right (_, v)) = v