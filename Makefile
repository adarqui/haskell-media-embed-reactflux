build:
	stack build --fast

clean:
	stack clean

tests:
	stack test --fast

ghci:
	stack ghci haskell-media-embed-reactflux
