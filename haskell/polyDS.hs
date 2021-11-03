import Data.List
import Data.Ord




-- Dense Polynomial

data DPoly = DPoly [Double]
	deriving (Eq, Show)

nullDPoly = DPoly []

degDPoly :: DPoly -> Int
degDPoly (DPoly as) = length as

toDPoly :: [Double] -> DPoly
toDPoly p = DPoly p

fromDPoly :: DPoly -> [Double]
fromDPoly (DPoly p) = p

-- Shift all factors to the right by `m`
shiftDPoly :: DPoly -> Int -> DPoly
shiftDPoly (DPoly as) m = DPoly (replicate m 0 ++ as)

-- Scalar multiplication
multDPoly :: Double -> DPoly -> DPoly
multDPoly 0 p = p
multDPoly t (DPoly as) = DPoly (map (*t) as)

addDPoly :: DPoly -> DPoly -> DPoly
addDPoly (DPoly as) (DPoly bs) = DPoly (addDPoly' as bs)
		where
			addDPoly' :: [Double] -> [Double] -> [Double]
			addDPoly' []	 bs		= bs
			addDPoly' as	 []		= as
			addDPoly' (a:as) (b:bs)	= (a + b) : addDPoly' as bs

subDPoly :: DPoly -> DPoly -> DPoly
subDPoly p q = addDPoly p (multDPoly (-1) q)

-- Product
prodDPoly :: DPoly -> DPoly -> DPoly
prodDPoly (DPoly [])		_			= nullDPoly
prodDPoly _					(DPoly [])	= nullDPoly
prodDPoly (DPoly (a:as))	q			= addDPoly aq q'
		where
			aq = multDPoly a q
			q' = prodDPoly (DPoly as) (shiftDPoly q 1)

-- Differential
diffDPoly :: DPoly -> DPoly
diffDPoly (DPoly as) = DPoly (tail $ map lowerExp $ zip [0..] as)
		where
			lowerExp :: (Int,Double) -> Double
			lowerExp (k,a) = a * fromIntegral k

-- Indefinite integral
intDPoly :: DPoly -> DPoly -- Without constant
intDPoly (DPoly as) = DPoly (0 : (map raiseExp $ zip [0..] as))
		where
			raiseExp :: (Int,Double) -> Double
			raiseExp (k,a) = a / fromIntegral (k+1)

-- Value of polynomial in point `x`
valDPoly :: DPoly -> Double -> Double
valDPoly (DPoly as) x = sum $ map evalExp $ zip [0..] as
		where
			evalExp :: (Int,Double) -> Double
			evalExp (k,a) = a * (x ^ fromIntegral k)



-- Sparse Polynomial

data SPoly = SPoly [(Int,Double)]
	deriving (Eq, Show)

nullSPoly = SPoly []

degSPoly :: SPoly -> Int
degSPoly (SPoly as) = foldr max 0 (map fst as)

toSPoly :: [(Int,Double)] -> SPoly
toSPoly p = SPoly p

fromSPoly :: SPoly -> [(Int,Double)]
fromSPoly (SPoly p) = p

-- Shift all factors to the right by `k`
shiftSPoly :: SPoly -> Int -> SPoly
shiftSPoly (SPoly as) m = SPoly (map (\(k,a) -> (k+m,a)) as)

-- Scalar multiplication
multSPoly :: Double -> SPoly -> SPoly
multSPoly 0 p = p
multSPoly t (SPoly as) = SPoly (map (\(k,a) -> (k,t*a)) as)

addSPoly :: SPoly -> SPoly -> SPoly
addSPoly (SPoly as) (SPoly bs) 	= SPoly (addSPoly' as bs)
		where
			addSPoly' :: [(Int,Double)] -> [(Int,Double)] -> [(Int,Double)]
			addSPoly' []	 bs		= bs
			addSPoly' as	 []		= as
			addSPoly' ((k,a):as) bs = if ksum == 0
									then addSPoly' as filtered
									else (k,ksum) : addSPoly' as filtered
					where 
						ksum = a + (sum $ map snd $ filter ((==k).fst) bs)
						filtered = filter (not.(==k).fst) bs

subSPoly :: SPoly -> SPoly -> SPoly
subSPoly p q = addSPoly p (multSPoly (-1) q)

-- Product
prodSPoly :: SPoly -> SPoly -> SPoly
prodSPoly (SPoly [])			_			= nullSPoly
prodSPoly _						(SPoly [])	= nullSPoly
prodSPoly (SPoly ((k,a):as))	q			= addSPoly aq q'
		where
			aq = multSPoly a (q `shiftSPoly` k)
			q' = prodSPoly (SPoly as) q

-- Differential
diffSPoly :: SPoly -> SPoly
diffSPoly (SPoly as) = SPoly (filter ((>0).snd) $ map lowerExp as)
		where
			lowerExp :: (Int,Double) -> (Int,Double)
			lowerExp (k,a) = (k-1,a * fromIntegral k)

-- Indefinite integral
intSPoly :: SPoly -> SPoly -- Without constant
intSPoly (SPoly as) = SPoly (map raiseExp $ as)
		where
			raiseExp :: (Int,Double) -> (Int,Double)
			raiseExp (k,a) = (k+1,a / fromIntegral (k+1))

-- Value of polynomial in point `x`
valSPoly :: SPoly -> Double -> Double
valSPoly (SPoly as) x = sum $ map evalExp as
		where
			evalExp :: (Int,Double) -> Double
			evalExp (k,a) = a * (x ^ fromIntegral k)

-- Sort factors by exponents
sortSPoly :: SPoly -> SPoly
sortSPoly (SPoly xs) = SPoly (sortBy (comparing fst) xs)




-- Convertions

sparseToDense :: SPoly -> DPoly
sparseToDense (SPoly []) = nullDPoly
sparseToDense (SPoly ((k,a):as)) = addDPoly (DPoly [a] `shiftDPoly` k)  (sparseToDense $ SPoly as)

denseToSparse :: DPoly -> SPoly
denseToSparse (DPoly []) = nullSPoly
denseToSparse p = SPoly (denseToSparse' p 0)
		where
			denseToSparse' (DPoly []) _ = []
			denseToSparse' (DPoly (a:as)) k = if a == 0
											then denseToSparse' (DPoly as) (k+1)
											else (k,a) : denseToSparse' (DPoly as) (k+1)




dtest1 = DPoly [1,2,1]
dtest2 = DPoly [2,3,0,-3]
stest1 = SPoly [(0,1),(1,2),(2,1)]
stest2 = SPoly [(0,2),(1,3),(3,-3)]

prodtest = prodDPoly dtest1 dtest2 == 
	(sparseToDense $ prodSPoly (denseToSparse dtest1) (denseToSparse dtest2))