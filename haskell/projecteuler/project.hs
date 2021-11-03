
main = putStrLn $ show doProblem3


isPrime :: Integer -> Bool
isPrime 1 = False
isPrime 0 = False
isPrime n = all ((/=0).(n `mod`)) [2..(n-1)]


primes = 2 : 3 : primes'
	where
		primes' = filter testPrime [4..]
		testPrime x = all (\p -> x `mod` p /=0) $ takeWhile (<x) primes



problem3 :: Integer -> Integer
problem3 n = problem3' n
	where
		primeFactors x = filter ((==0).(x `mod`)) $ takeWhile (<x) primes
		problem3' n
			| null $ primeFactors n = n
			| otherwise = problem3' (n `div` (head $ primeFactors n))

doProblem3 = problem3 600851475143  


isPalindrome :: Integer -> Bool
isPalindrome n = show n == (reverse $ show n)

palindromes = filter isPalindrome $ map (1000000-) [1..]
problem4Test x = head $ dropWhile (\a -> a `mod` x /= 0 || a `div` x > 1000) palindromes


problem4 = maximum $ take 998 $ map (problem4Test.(1000-)) [1..]




problem5 = foldl check (product $ filter isPrime [1..20]) [1..20]
	where
		check n x
			| n `mod` x == 0 = n
			| otherwise = n * (x `div` (n `mod` x))


problem6 n = squareOfSums - sumOfSquares
	where
		sumOfSquares = sum $ map (^2) [1..n]
		squareOfSums = (^2) $ sum [1..n]