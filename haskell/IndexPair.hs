module IndexPair where

indexPair :: (Integral a) => (a,a) -> a
indexPair (x,y)
	| x < 0 || y < 0 = undefined
	| x > y	= x*x + 2*(x-y)
	| x < y	= y*y + 2*(y-x) - 1
	| otherwise = x*x

unindexPair :: (Integral a) => a -> (a,a)
unindexPair n
	| n < 0 = undefined
	| otherwise = case ((n - x*x + 1) `divMod` 2) of
		(y,0) -> (x-y,x)
		(y,1) -> (x,x-y)
	where
		x = floor $ sqrt $ fromIntegral n

indexPairBound :: (Integral a) => a -> a -> (a,a) -> a
indexPairBound xb yb (x,y)
	| x < 0 || y < 0 || x >= xb || y >= yb = undefined
	| otherwise = x*yb + y

unindexPairBound :: (Integral a) => a -> a -> a -> (a,a)
unindexPairBound xb yb n
	| n < 0 = undefined
	| otherwise = n `divMod` yb
