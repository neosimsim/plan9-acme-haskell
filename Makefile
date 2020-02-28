.POSIX:

PACKAGES=\
	Network-NineP-Client \
	plan9-acme \
	plan9-acme-examples \

all: $(PACKAGES)

$(PACKAGES): phony
	$(MAKE) -C $@
	$(MAKE) -C $@ test
	$(MAKE) -C $@ check

phony: missing-file
missing-file: