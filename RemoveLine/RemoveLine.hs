import Control.Applicative
import Data.Char
import MyString.Line
import MyString.Number
import System.Environment
import Util.Console
import Prelude hiding (lines)

main :: IO ()
main = do
  args <- getArgs
  let lineToBeDropped = getNumbersAndRanges args
  contents <- getContents

  case lineToBeDropped of
    [] -> putStrLn $ showWithNumbers $ lines contents
    lineToBeDropped -> print $ removeNumbers (lines contents) lineToBeDropped
