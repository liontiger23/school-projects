import System.Environment (getArgs)

main = doIO id
	where doIO f = do
		args <- getArgs
		case args of 
			input:output:_ -> writeFile output (f (readFile input))
			_ -> putStrLn "error: some problem with arguments"