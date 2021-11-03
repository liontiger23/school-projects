
data Poly = Poly [Double]
	deriving (Eq, Show)

nullPoly = Poly []

toPoly :: [Double] -> Poly
toPoly p = Poly p

fromPoly :: Poly -> [Double]
fromPoly (Poly p) = p

shiftPoly :: Poly -> Poly
shiftPoly (Poly xs) = Poly (0 : xs)

multPoly :: Double -> Poly -> Poly
multPoly 0 p = p
multPoly a (Poly xs) = Poly (map (*a) xs)

addPoly :: Poly -> Poly -> Poly
addPoly (Poly xs) (Poly ys) = Poly (addPoly' xs ys)
		where
			addPoly' :: [Double] -> [Double] -> [Double]
			addPoly' (x:xs) (y:ys)	= (x + y) : addPoly' xs ys
			addPoly' []		ys		= ys
			addPoly' xs		[]		= xs

subPoly :: Poly -> Poly -> Poly
subPoly p q = addPoly p (multPoly (-1) q)

prodPoly :: Poly -> Poly -> Poly
prodPoly (Poly [])		_			= nullPoly
prodPoly _				(Poly [])	= nullPoly
prodPoly (Poly (x:xs))	q			= addPoly xq q'
		where
			xq = multPoly x q
			q' = prodPoly (Poly xs) (shiftPoly q)