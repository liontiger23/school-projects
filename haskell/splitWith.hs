import Data.Char

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith p [x]
	| p x = [[x]]
	| otherwise = []
splitWith p (x:y:xs)
	| p x && p y		= (x : head rest) : tail rest
	| p x && not (p y)	= [x] : rest
	| otherwise			= rest
	where rest = splitWith p (y:xs)