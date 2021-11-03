import Data.Char;

-- Range count

-- Get chars between `l` an `r` that appear `k` times in string `s`
countEq :: Char -> Char -> Int -> [Char] -> [Char]
countEq l r k s = filter (`inRange` (l,r)) (map fst dict)
		where
			dict = filter ((==2) . snd) (sumPairs (zip s ones))
			ones = 1 : ones


-- Check whether `x` is in range between `l` and `r`
inRange :: Char -> (Char,Char) -> Bool
inRange x (l,r)
		| x >= l && x <= r 	= True
		| otherwise			= False


-- Sum pairs that have common first element
sumPairs :: [(Char,Int)] -> [(Char,Int)]
sumPairs [p] 	= [p]
sumPairs (p@(pa,pb):ps) = sumPair p ps : (filter neKey (sumPairs ps))
		where
			neKey :: (Char,Int) -> Bool
			neKey (a,_)
				| a == pa	= False
				| otherwise = True
			sumPair :: (Char,Int) -> [(Char,Int)] -> (Char,Int)
			sumPair (a,b) ((c,d):ps)
				| a == c 	= sumPair (a,b + d) ps
				| otherwise = sumPair (a,b) 	ps
			sumPair p _ = p

