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
  let lineToBeSelected = getNumbersAndRanges args
  contents <- getContents

  case lineToBeSelected of
    [] -> putStrLn $ showWithNumbers $ lines contents
    lineToBeSelected -> print $ selectNumbers (lines contents) lineToBeSelected
