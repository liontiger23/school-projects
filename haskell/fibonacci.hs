fib1 = 1:1: [(a + b) | (a,b) <- zip fib1 $ tail fib1]
fib2 = 1:1: map (\(a,b) -> a + b) (zip fib2 $ tail fib2)

fib3 = fibr 1 1
	where fibr a b = a : fibr b (a+b)

-- VERY slow & inefficient
fib4 = [fibr i | i <- [0..]]
	where 
		fibr 0 = 1
		fibr 1 = 1
		fibr x = fibr (x-1) + fibr (x-2) 

-- ULTIMATE
fib5 = [round( (1 / sqrt(5)) * ((1 + sqrt(5))/2) ** x ) | x <- [1..]]