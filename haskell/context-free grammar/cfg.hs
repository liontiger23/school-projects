import Data.List
import Data.Ord

data Rule = Rule (Char,String)
	deriving (Eq,Show)

-- Generator

genLanguage :: [Rule] -> [String]
genLanguage = concat . genLanguageByDepth

genLanguageByDepth :: [Rule] -> [[String]]
genLanguageByDepth rs = map (genSubLanguage 'S' rs) [1..]

genSubLanguage :: Char -> [Rule] -> Int -> [String]
genSubLanguage c rs 1 = filter (`allTerminal` rs) (getRules c rs)
genSubLanguage c rs k = concat $ map applyRules $ nonTerms
			where
				nonTerms = filter (`anyNonTerminal` rs) $ getRules c rs
				applyRules :: String -> [String]
				applyRules [] = [[]]
				applyRules (x:xs)
					| x `isTerminal` rs = map (x:) (applyRules xs)
					| otherwise			= combinationsWith (++) 
						(genSubLanguage x rs (k-1)) (applyRules xs)

-- Helpers

getRules :: Char -> [Rule] -> [String]
getRules c = map snd . filter ((==c).fst) . fromRules

fromRules :: [Rule] -> [(Char,String)]
fromRules = map fromRule

fromRule :: Rule -> (Char,String)
fromRule (Rule (x,s)) = (x,s)

toRules :: [(Char,String)] -> [Rule]
toRules (x:xs)	= Rule x : toRules xs
toRules []		= []

getNonTerminals :: [Rule] -> [Char]
getNonTerminals = nub . map fst . fromRules

isNonTerminal :: Char -> [Rule] -> Bool
isNonTerminal c = (c `elem`) . getNonTerminals

isTerminal c = not . isNonTerminal c

anyNonTerminal :: String -> [Rule] -> Bool
anyNonTerminal s rs = any (`isNonTerminal` rs) s

allTerminal s = not . anyNonTerminal s

-- All combinations of two lists with `f` applied to them
combinationsWith :: (a -> a -> a) -> [a] -> [a] -> [a]
combinationsWith _ []	  bs = bs
combinationsWith _ as	  [] = as
combinationsWith f (a:[]) bs = map (f a) bs
combinationsWith f (a:as) bs = map (f a) bs ++ combinationsWith f as bs

-- IO

readRules :: String -> [Rule]
readRules = map readRule . filter validRule . lines

readRule :: String -> Rule
readRule (x:'-':'>':s)  = Rule (x,s)
readRule s				= error $ "Invalid production rule:" ++ s

validRule :: String -> Bool
validRule (x:'-':'>':_) = True
validRule _				= False

readRulesFrom :: FilePath -> IO [Rule]
readRulesFrom s = do
				x <- readFile s
				return $ readRules x

processRules :: FilePath -> FilePath -> Int -> IO ()
processRules infile outfile k = do 
		x <- readRulesFrom infile
		writeFile outfile $ unlines $ filter ((<=30) . length)  $ filter ((>=20) . length) $ concat $ take k $ genLanguageByDepth x

printRules :: FilePath -> FilePath -> IO ()
printRules infile outfile = do
		x <- readRulesFrom infile
		writeFile outfile $ show x

--main = do 
--	x <- readRulesFrom "algExpr.txt"
--	writeFile "out.txt" $ unlines $ take 10000 $ genLanguage x

