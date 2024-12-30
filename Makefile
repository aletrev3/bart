.PHONY: all
all: dune-project
	dune build

.PHONY: clean
clean: dune-project
	dune clean
