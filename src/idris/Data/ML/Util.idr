-- ---------------------------------------------------------------- [ Util.idr ]

module Data.ML.Util

%access public export


||| Convert a Bool to an Integer, as in C99's <stdbool.h>.
||| @ bool a Bool to convert
boolToInteger : (bool : Bool) -> Integer
boolToInteger False = 0
boolToInteger True  = 1


||| Cast Bools to Integers via `boolToInteger`.
implementation Cast Bool Integer where
  cast = boolToInteger


||| Simplified clone of `numpy.unique`.
|||
||| Return the sorted unique elements of a list.
|||
||| ```
||| unique = sort . nub
||| ```
unique : Ord a => List a -> List a
unique = sort . nub

-- --------------------------------------------------------------------- [ EOF ]
