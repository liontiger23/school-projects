import Data.List
import Data.Array
import Data.Ix
import Debug.Trace

lcsLexical :: String -> String -> String
lcsLexical x y = lcsLexical' x y ""
	where
		lcsLexical' :: String -> String -> String -> String
		lcsLexical' [] _ res = reverse res
		lcsLexical' _ [] res = reverse res
		lcsLexical' xxs@(x:xs) yys@(y:ys) res
			| x == y = trace (debug "=") $ 
						lcsLexical' xs ys (x:(dropWhile (<x) res))
			| x > y  = trace (debug ">") $ 
						case hasNext x yys of
				Nothing -> lcsLexical' xs yys res
				Just ts -> lcsLexical' xxs ts  res
			| x < y  = trace (debug "<") $ 
						lcsLexical' yys xxs res
			where
				debug s = xxs++" | "++yys++" :: "++res++"\n"++"("++[x]++" "++s++" "++[y]++")\n"

hasNext :: Char -> String -> Maybe String
hasNext k xs
	| any (==k) xs 	= Just (dropWhile (<k) xs)
	| otherwise		= Nothing

{-
hasNext :: Char -> String -> Maybe String
hasNext _ [] = Nothing
hasNext k xxs@(x:xs)
	| k == x = Just xxs
	| k > x  = hasNext k xs
	| k < x  = case hasNext k xs of 
		Nothing -> Nothing
		Just ts -> Just xxs
-}
