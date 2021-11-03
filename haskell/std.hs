-- Tuples
myFst (a, _) = a
mySnd (_, b) = b

-- Lists

myHead (x:_) = x;
myTail (:xs) = xs;

myTake 0 _ = []
myTake _ [] = []
myTake n (x:xs) = x : myTake (n-1) xs

myDrop _ [] = []
myDrop 0 xs = xs
myDrop n (_:xs) = myDrop (n-1) xs

myLength [] = 0
myLength (_:xs) = 1 + myLength xs

type myInt Int;

data Struct = Struct
			| StructIS Int String
			| StructIIS Int Int String
			| StructSS String String


myMax a b
	| a > b		= a
	| otherwise	= b

myTranspose :: [[a]] -> [[a]]
myTranspose [] = []
myTranspose xs = map head ys : myTranspose (map tail ys)
				where 
					ys = filter notNull xs
					notNull x = not (null x)

myMap :: (a -> b) -> [a] -> [b]
myMap f (x:xs) = f x : myMap f xs
myMap _ _ = []