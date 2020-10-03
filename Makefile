setup: install test docs run

run:
	iex -S mix

install:
	mix deps.get

test:
	mix test

docs:
	mix docs