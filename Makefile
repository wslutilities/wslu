AUTOMAKE_OPTIONS = foreign
HEADER = src/wslu-header
OUTPATH = out

SOURCES := $(wildcard src/*.sh)
ETC := $(wildcard src/etc/*)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done

clean:
	rm out

test:
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslfetch.bats
