import Data.List

data Vector3 = V3 (Double, Double, Double)
		deriving (Eq, Show)
		
data Point3 = P3 (Double, Double, Double)
		| None
		deriving (Eq, Show)

data Line = Line Point3 Vector3
		deriving (Eq, Show)

data Plane = Plane Point3 Vector3 Vector3
		deriving (Eq, Show)

xv3 :: Vector3 -> Double
xv3 (V3 (x,_,_)) = x

yv3 :: Vector3 -> Double
yv3 (V3 (_,y,_)) = y

zv3 :: Vector3 -> Double
zv3 (V3 (_,_,z)) = z

xp3 :: Point3 -> Double
xp3 (P3 (x,_,_) )= x

yp3 :: Point3 -> Double
yp3 (P3 (_,y,_) )= y

zp3 :: Point3 -> Double
zp3 (P3 (_,_,z) )= z

toPoint :: Vector3 -> Point3
toPoint (V3 v) = P3 v

toVector :: Point3 -> Vector3
toVector (P3 p) = V3 p

vectorFromPoints :: Point3 -> Point3 -> Vector3
vectorFromPoints a b = toVector b `subVector` toVector a

lineFromPoints :: Point3 -> Point3 -> Line
lineFromPoints a b = Line a (vectorFromPoints a b)

collinear :: Vector3 -> Vector3 -> Bool
collinear (V3 (a1,a2,a3)) (V3 (b1,b2,b3))
	| a1*b2 - a2*b1 /= 0 = False
	| a1*b3 - a2*b3 /= 0 = False
	| otherwise			 = True

complanar :: Vector3 -> Vector3 -> Vector3 -> Bool
complanar (V3 (a1,a2,a3)) (V3 (b1,b2,b3)) (V3 (c1,c2,c3))
	| a1*b2*c3 + a2*b3*c1 + a3*b1*c2
		- a3*b2*c1 - a2*b1*c3 - a1*b3*c2 == 0 	= True
	| otherwise									= False

intersectLines :: Line -> Line -> Point3
intersectLines (Line a v) (Line b u) = 
		if complanar v u ab
		then if collinear v u
			then None
			else toPoint $ toVector a `addVector` (t `multVector` v)
		else None 
	where
		ab = vectorFromPoints a b
		t = calculateParam a v b u
		calculateParam :: Point3 -> Vector3 -> Point3 -> Vector3 -> Double
		calculateParam (P3 (a1,a2,a3)) (V3 (v1,v2,v3)) (P3 (b1,b2,b3)) (V3 (u1,u2,u3)) = 
				(a1*u2 + b2*u1 - a2*u1 - b1*u2) / (u1*v2 - u2*v1)

intersectFromPoints :: Point3 -> Point3 -> Point3 -> Point3 -> Point3
intersectFromPoints a b c d = intersectLines (lineFromPoints a b) (lineFromPoints c d)

addVector :: Vector3 -> Vector3 -> Vector3
addVector (V3 (a1,a2,a3)) (V3 (b1,b2,b3)) = V3 (a1+b1,a2+b2,a3+b3)

subVector :: Vector3 -> Vector3 -> Vector3
subVector a b = a `addVector` ((-1) `multVector` b)

multVector :: Double -> Vector3 -> Vector3
multVector t (V3 (a1,a2,a3)) = V3 (t*a1,t*a2,t*a3)


p1 = P3 (2,2,0)
p2 = P3 (3,3,0)
p3 = P3 (0,2,0)
p4 = P3 (0,3,0)


