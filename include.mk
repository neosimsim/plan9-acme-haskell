all:
	$(MAKE) build
	$(MAKE) test

build:
	cabal v2-build -f pedantic $(CABAL_ARGS) $(PACKAGE)

test: $(TESTS-SUITES)

$(TESTS-SUITES):
	cabal v2-run -f pedantic $(CABAL_ARGS) $(PACKAGE):$@ -- $(TEST_ARGS)

check:
	cabal $(CABAL_ARGS) check
	cabal-fmt  $(PACKAGE).cabal | diff $(PACKAGE).cabal -
	hfmt

check-apply: phony
	cabal-fmt -i $(PACKAGE).cabal
	hfmt -w

phony: missing-file
missing-file: