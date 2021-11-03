import Data.List
import Data.Ord

data List a = Cons a (List a)
	| Nil
	deriving (Show)

fromList [] = Nil
fromList (x:xs) = Cons x (fromList xs)

toList Nil = []
toList (Cons x xs) = x:(toList xs)

data Tree a = Child a (Tree a) (Tree a)
	| Empty
	deriving (Show)

data TreeMB a = ChildMB a (Maybe (TreeMB a)) (Maybe (TreeMB a))
	deriving (Show)

mylength [] = 0
mylength (_:xs) = 1 + mylength xs

mean [] = 0
mean xs = (sum xs) / (fromIntegral $ length xs)

palindrome [] = []
palindrome (x:xs) = x : (palindrome xs) ++ [x];

isPalindrome [] = True
isPalindrome (x:xs) = x == last xs && isPalindrome (init xs)

myintersperse :: a -> [[a]] -> [a]
myintersperse _ [] = []
myintersperse _ [x] = x
myintersperse s (x:xs) = x ++ [s] ++ (myintersperse s xs)

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Child _ x y) = 1 + max (treeHeight x) (treeHeight y)

-- Geometry

data Direction = Straight
	| LeftTurn
	| RightTurn
	deriving (Eq,Show)

type Vector2D = (Double,Double)
type Point2D = Vector2D

--vectorFromPoint :: Point2D -> Vector2D
--vectorFromPoint a = a

vectorFromPoints :: Point2D -> Point2D -> Vector2D
vectorFromPoints (ax,ay) (bx,by) = (bx-ax,by-ay)

vproduct2 :: Vector2D -> Vector2D -> Double
vproduct2 (ax,ay) (bx,by) = (ax*by) - (ay*bx)

sproduct :: Vector2D -> Vector2D -> Double
sproduct (ax,ay) (bx,by) = ax*bx + ay*by

vlength2 :: Vector2D -> Double
vlength2 (x,y) = x*x + y*y

vlength :: Vector2D -> Double
vlength a = sqrt $ vlength2 a

direction :: Point2D -> Point2D -> Point2D -> Direction
direction a b c 
	| vp == 0 = Straight
	| vp > 0 = RightTurn
	| vp < 0 = LeftTurn
		where
			ba = vectorFromPoints b a
			bc = vectorFromPoints b c
			vp = vproduct2 ba bc

directions :: [Point2D] -> [Direction]
directions (a:b:c:xs) = (direction a b c) : (directions (b:c:xs))
directions (_:[]) = error "must be more than one element in list"
directions (_:_:[]) = error "must be more than two elements in list"
directions _ = []

grahamScan :: [Point2D] -> [Point2D]
grahamScan [] = []
grahamScan ts = grahamScan_ (p:vs) []
	where
		ps = sortBy (comparing fst) ts
		vs = sortBy dOrder (tail ps)
		p = head ps
		dOrder x y = case direction x p y of
						Straight -> EQ
						LeftTurn -> GT
						RightTurn -> LT
		grahamScan_ [] ys = ys
		grahamScan_ (x:y:z:xs) [] = grahamScan_ xs (z:y:x:[])
		grahamScan_ (x:xs) ys = 
			if length ys < 3 || head (directions (x:ys)) == head (directions ys)
				then grahamScan_ xs (x:ys)
				else grahamScan_ (x:xs) (tail ys)
		grahamScan_ _ [] = []