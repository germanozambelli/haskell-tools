module Util.Console where

import Data.List
import Data.Maybe
import MyString.Number
import Text.Read (readMaybe)
import Text.Regex.Posix

rangeRegEx :: [Char]
rangeRegEx = "^([-+]?[0-9]+)\\.{2}([-+]?[0-9]+)$"

numberRegEx :: [Char]
numberRegEx = "^[-+]?[0-9]+$"

getNumbersAndRanges :: [String] -> [DenormalizedNumber]
getNumbersAndRanges a = getRanges a ++ getNumbers a

getRanges :: [String] -> [DenormalizedNumber]
getRanges a = mapMaybe getRange (filter isRange a)

getRange :: String -> Maybe DenormalizedNumber
getRange a = range (getAllTextSubmatches $ a =~ rangeRegEx :: [String])
  where
    range [] = Nothing
    range [_, x, y] = Just $ Range (read x, read y)

isRange :: String -> Bool
isRange a = a =~ rangeRegEx :: Bool

getNumbers :: [String] -> [DenormalizedNumber]
getNumbers a = map (DenormalizedNumber . read) (filter isNumber a)

isNumber :: String -> Bool
isNumber a = a =~ numberRegEx :: Bool