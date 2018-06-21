module CommandOptions where

import Data.Semigroup ((<>))
import Options.Applicative

-- | Command line arguments 
data CommandArgs = CommandArgs
  { csv :: String
  , json :: String
  }

-- | The command argument parser
commandParser :: Parser CommandArgs
commandParser =
  CommandArgs <$>
  argument
    str
    (metavar "[CSV_PATH]" <> help "The path to the CSV file to convert.") <*>
  argument
    str
    (metavar "[OUTPUT_NAME]" <> help "The filename for the JSON output.")

-- | Creates the command line info
argumentHelper :: ParserInfo CommandArgs
argumentHelper =
  info
    (commandParser <**> helper)
    (fullDesc <> progDesc "Converts a CSV file to a JSON file." <>
     header "============================================================")