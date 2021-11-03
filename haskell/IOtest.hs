import Data.List
import Data.Char

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge xxs@(x:xs) yys@(y:ys)
		| x < y 	= x : merge xs yys
		| x == y 	= x : merge xs ys
		| otherwise = y : merge ys xxs

mergeSort :: (Ord a) => [a] -> [a]
mergeSort xs = mergeSort' xs (length xs)
	where
		mergeSort' [x] 1 = [x]
		mergeSort' xs n = merge (mergeSort' (take l xs) l) (mergeSort' (drop l xs) r)
			where
				l = n `div` 2
				r = n - l

{-
main = interact $ concat . intersperse "-" . sort . nub . 
					map ((:[]) . head) . 
						filter (both (not . null) (isAlpha . head)) . 
						lines

both :: (a -> Bool) -> (a -> Bool) -> a -> Bool
both f g x = f x && g x

none :: (a -> Bool) -> (a -> Bool) -> a -> Bool
none f g = both (not . f) (not . g)





minCount :: (Ord a) => [a] -> (a,Int)
minCount (x:xs) = minCount' x 1 xs
	where
		minCount' m c (x:xs)
			| m > x  	= minCount' x 1 	xs
			| m == x 	= minCount' m (c+1) xs
			| otherwise = minCount' m c 	xs
		minCount' m c [] = (m,c)


findPair :: [Double] -> Maybe (Double,Double)
findPair (x:y:xs)
	| x*y < 0 && x + y > 0 	= Just (x,y)
	| otherwise 			= findPair (y:xs)
findPair [x] 	= Nothing
findPair []		= Nothing -}
