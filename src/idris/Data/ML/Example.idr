-- ------------------------------------------------------------- [ Example.idr ]

module Data.ML.Example

import public Data.ML.Categorical

%access public export


-- --------------------------------------------- [ Categorical Feature Example ]

namespace Categorical

  exampleData : List String
  exampleData = [ "male",   "female", "male",   "male"
                , "female", "male",   "female", "female"
                ]


  ||| ```idris example
  ||| catToNum Categorical.exampleData
  ||| ```
  example : List (List Integer)
  example = catToNum Categorical.exampleData


-- --------------------------------------------------------- [ Titanic Example ]

namespace Titanic

  exampleData : List String
  exampleData = [ "C65", "", "E36", "C54", "B57 B59 B63 B66" ]


  -- TODO: record CabinFeature where

  ||| ```idris example
  ||| Titanic.example
  ||| ```
  example : List (Char, Integer, Nat)
  example = go . words <$> Titanic.exampleData
    where
      go : List String -> (Char, Integer, Nat)
      go []                                            = ('X', -1, 0)
      go (cabin :: cabins) with (strM cabin)
        go (""            :: cabins) | StrNil          = ('X', -1, 0)
        go (strCons c num :: cabins) | (StrCons c num) =
           ( c
           , cast num
           , S (length cabins)
           )

-- --------------------------------------------------------------------- [ EOF ]
