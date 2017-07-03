-- --------------------------------------------------------- [ Categorical.idr ]

module Data.ML.Categorical

import public Data.ML.Util

%access export


catToNum : (Num n, Cast Bool n, Ord a) => List a -> List (List n)
catToNum xs = [ cast . (== cat) <$> xs | cat <- unique xs ]

-- --------------------------------------------------------------------- [ EOF ]
