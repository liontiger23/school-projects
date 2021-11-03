import Data.List
import Data.Ix
import Control.Monad.ST
import Control.Monad
import Data.Array.ST
import Data.Array

showElems :: [(Int,Int)] -> [String]
showElems = map (show . (mem!))

memBounds = ((0,0),(10,10))
mem2Bounds = ((0,0),(10^9,10^9))

mem = runSTArray $ do 
		arr <- newArray memBounds 0
		forM_ (range memBounds) $ \(i,j) ->
			writeArray arr (i,j) (i+j)
		return arr

mem2 = array mem2Bounds [((i,j),wins i j) | (i,j) <- range mem2Bounds]

countWins a1 a2 b1 b2 = count (==True) $ map (mem2!) (range ((a1,b1),(a2,b2)))

wins x y
	| x == y = False
	| x == 0 = False
	| y == 0 = False
	| otherwise = if any (==False) (winsX ++ winsY)
			then True
			else False
		where
			winsX = [mem2!(x,i) | i<-filter (>=0) [(y-x),(y-2*x)..]]
			winsY = [mem2!(i,y) | i<-filter (>=0) [(x-y),(x-2*y)..]]



count :: (a -> Bool) -> [a] -> Int
count _ [] = 0
count f (x:xs)
	| f x 		= 1 + count f xs
	| otherwise = count f xs


