module MyString.Number where

import Data.List

type Number = Int

data DenormalizedNumber = DenormalizedNumber Int | Range (Int,Int)

class Numberable a where
  number :: a -> Number

class NumerableCollection a where
  normalizeNumbers :: a -> [DenormalizedNumber] -> [Number]
  filterByNumbers :: (Number -> [Number] -> Bool) -> a -> [DenormalizedNumber] -> a
  showWithNumbers :: a -> String

startNumber :: Number
startNumber = 1 --non cambiare altrimenti si rompono le implementazioni di normalizeNumbers

normalizeNumberOnList :: [a] -> [DenormalizedNumber] -> [Number]
normalizeNumberOnList list = nub . concatMap (normalize list)
    where
      normalize list (Range (start, end)) = [(head (normalize list (DenormalizedNumber start))) .. (head (normalize list (DenormalizedNumber end)))]
      normalize _ (DenormalizedNumber 0) = [startNumber]
      normalize list (DenormalizedNumber number)
        | number >= 1 = [number]
        | otherwise = [length list + (number + 1)]

fOnNumber :: (Numberable a) => [Number] -> (Number -> [Number] -> Bool) -> a -> Bool
fOnNumber numbers filterFunction numerable = filterFunction (number numerable) numbers

selectNumbers :: (NumerableCollection a) => a -> [DenormalizedNumber] -> a
selectNumbers = filterByNumbers elem

removeNumbers :: (NumerableCollection a) => a -> [DenormalizedNumber] -> a
removeNumbers = filterByNumbers notElem

showWithNumber :: (Numberable a, Show a) => a -> String
showWithNumber a = "[" ++ show (number a) ++ "]" ++ show a
