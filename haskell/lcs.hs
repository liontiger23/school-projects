-- longest common subsequence


lcsWith :: (Ord a) => ([a] -> [a] -> [a]) -> [a] -> [a] -> [a]
lcsWith _ xs [] = []
lcsWith _ [] ys = []
lcsWith longest xxs@(x:xs) yys@(y:ys)
	| x == y 	= x : lcsWith longest xs ys
	| otherwise = longest (lcsWith longest xs yys) (lcsWith longest xxs ys)





lcsLexical :: (Ord a) => [a] -> [a] -> [a]
lcsLexical xs [] = []
lcsLexical [] ys = []
lcsLexical xxs@(x:xs) yys@(y:ys) = foldl longestLexical [] drops
	where
		drops = dropX : dropY : dropXY
		dropX = lcsLexical xs yys
		dropY = lcsLexical xxs ys
		dropXY = if x == y then (x : lcsLexical xs ys) : [] else []
--		where
longestLexical xs ys
	| compareLexical xs ys == GT = xs
	| otherwise					 = ys

compareLexical :: (Ord a) => [a] -> [a] -> Ordering
compareLexical [] [] = EQ
compareLexical _  [] = GT
compareLexical [] _  = LT
compareLexical xxs@(x:xs) yys@(y:ys)
	| x == y 	= compareLexical xs ys
	| x < y 	= LT
	| otherwise = GT






lcs :: (Ord a) => [a] -> [a] -> [a]
lcs xs ys = lcsWith longest xs ys
	where
		longest xs ys
			| length xs > length ys = xs
			| otherwise 			= ys


{-
lcs :: [a] -> [a] -> [a]
lcs _ xs [] = []
lcs _ [] ys = []
lcs xxs@(x:xs) yys@(y:ys)
	| x == y 	= x : lcs xs ys
	| otherwise = longest (lcs xs yys) (lcs xxs ys)
		where longest xs ys
				| length xs > length ys = xs
				| otherwise 			= ys
-}
