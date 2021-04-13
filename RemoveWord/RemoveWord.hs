import Control.Applicative
import Control.Monad (forever, when)
import Data.Char
import MyString.Line
import MyString.Number
import System.Environment
import System.Exit (exitSuccess)
import System.IO (isEOF)
import Util.Console

readAllLine wordNumbers = forever $ do
  finish <- isEOF
  when finish exitSuccess
  l <- getLine
  case wordNumbers of
    [] -> putStrLn $ showWithNumbers (line 0 l)
    wordNumbers -> print $ removeNumbers (line 0 l) wordNumbers 
  readAllLine wordNumbers

main :: IO ()
main = do
  args <- getArgs
  let wordNumbers = getNumbersAndRanges args
  readAllLine wordNumbers
