module MyString.Line where

import Data.List hiding (words)
import MyString.Number
import MyString.Word

import Prelude hiding (words, Word)

newtype Line = Line (Number, Words)

instance Numberable Line where
  number (Line (n, _)) = n

instance Show Line where
  show (Line (_, words)) = show words

instance NumerableCollection Line where
  normalizeNumbers (Line (_, words)) = normalizeNumbers words
  filterByNumbers filterFunction (Line (number, words)) denormalizedNumbers = Line (number,filterByNumbers filterFunction words denormalizedNumbers)
  showWithNumbers (Line (_, words)) = showWithNumbers words

line :: Number -> String -> Line
line number text = Line (number, words text)

newtype Lines = Lines [Line]

instance Show Lines where
  show (Lines lines) = intercalate "\n" $ map show lines

instance NumerableCollection Lines where
  normalizeNumbers (Lines lines) = normalizeNumberOnList lines
  filterByNumbers filterFunction lines@(Lines l) numbers = Lines $ filter (fOnNumber (normalizeNumbers lines numbers) filterFunction) l
  showWithNumbers (Lines lines) = intercalate "\n" $ map showWithNumber lines

lines :: String -> Lines
lines string = Lines $ zipWith line [startNumber ..] (Prelude.lines string)

removeWords :: Lines -> [DenormalizedNumber] -> Lines
removeWords (Lines lines) denormalizedNumber = Lines $ map (`removeNumbers` denormalizedNumber) lines 

selectWords :: Lines -> [DenormalizedNumber] -> Lines
selectWords (Lines lines) denormalizedNumber = Lines $ map (`selectNumbers` denormalizedNumber) lines
