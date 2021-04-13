module MyString.Word where

import MyString.Number
import Prelude hiding (Word)

-- Word ----------------------------------------------------------------------------------------
newtype Word = Word (Number, String)
  deriving (Eq)

instance Show Word where
  show (Word (_, text)) = text

instance Numberable Word where
  number (Word (n, _)) = n

word :: Number -> String -> Word
word number text = Word (number, text)

-- Words ---------------------------------------------------------------------------------------

newtype Words = Words [Word]

instance Show Words where
  show (Words words) = unwords $ map show words

instance NumerableCollection Words where
  normalizeNumbers (Words words) = normalizeNumberOnList words
  filterByNumbers filterFunction words@(Words w) numbers = Words $ filter (fOnNumber (normalizeNumbers words numbers) filterFunction) w
  showWithNumbers (Words words) = unwords $ map showWithNumber words

words :: String -> Words
words string = Words (zipWith word [startNumber ..] (Prelude.words string))
