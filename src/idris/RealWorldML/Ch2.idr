-- ----------------------------------------------------------------- [ Ch2.idr ]

module RealWorldML.Ch2

-- ----------------------------------------------------------- [ Private Parts ]

%access private


implementation Cast Bool Integer where
  cast False = 0
  cast True  = 1


||| Simplified clone of `numpy.unique`.
|||
||| Return the sorted unique elements of a list.
unique : (Ord a) => List a -> List a
unique = sort . nub


-- --------------------------------------------- [ Categorical Feature Example ]

%access export


catData : List String
catData = [ "male",   "female", "male",   "male"
          , "female", "male",   "female", "female"
          ]


||| ```idris example
||| catToNum catData
||| ```
catToNum : (Ord a) => List a -> List (List Integer)
catToNum xs = [ cast . (== cat) <$> xs | cat <- sort (nub xs) ]


-- --------------------------------------------------------- [ Titanic Example ]

%access export


cabinData : List String
cabinData = [ "C65", "", "E36", "C54", "B57 B59 B63 B66" ]


||| ```idris example
||| cabinFeatures cabinData
||| ```
cabinFeatures : List String -> List (Char, Integer, Nat)
cabinFeatures = map $ go . words
  where
    go : List String -> (Char, Integer, Nat)
    go [] = ('X', -1, 0)
    go (cabin :: cabins) with (strM cabin)
      go ("" :: cabins) | StrNil = ('X', -1, 0)
      go ((strCons c num) :: cabins) | (StrCons c num) =
          (c, cast num, S (length cabins))


-- --------------------------------------------------------------------- [ EOF ]
