AUTOMAKE_OPTIONS = foreign
HEADER = src/wslu-header
OUTPATH = out
CURPATH = $(shell pwd)

SOURCES := $(wildcard src/*.sh)
ETCFILES := $(wildcard src/etc/*)
OUTFILES := $(wildcard out/*)
MANFILES := $(wildcard docs/*)
INSTEDEXES := $(wildcard /usr/bin/wsl*)
INSTEDMANS := $(wildcard /usr/share/man/man1/wsl*)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done
	chmod +x $(OUTPATH)/*

install:
	install -Dm 555 docs/* -t $(DESTDIR)/share/man/man1
	install -Dm 755 out/* -t $(DESTDIR)/bin
	install -Dm 555 src/etc/* -t $(DESTDIR)/share/wslu

uninstall: 
	for f in $(INSTEDEXES); do \
    	rm -f $$f; \
	done
	for f in $(INSTEDMANS); do \
    	rm -f $$f; \
	done
	rm -rf /usr/share/wslu

clean:
	rm -rf $(OUTPATH)

docs:
	bash extras/script/doc_handler.sh

test:
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslvar.bats tests/wslfetch.bats tests/wslview.bats
