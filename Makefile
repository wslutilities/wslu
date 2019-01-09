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

link:
	for file in $(OUTFILES); do \
		ln -s $(CURPATH)/$$file /usr/bin/`basename $$file`; \
	done
	for file in $(MANFILES); do \
		ln -s $(CURPATH)/$$file /usr/share/man/man1/`basename $$file`; \
	done
	ln -s src/etc /usr/share/wslu

install:
	install -m755 out/* /usr/bin
	install -m644 docs/* /usr/share/man/man1
	[ -d /usr/share/wslu ] || mkdir -p /usr/share/wslu
	cp src/etc/* /usr/share/wslu

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

test:
	PATH="$$CURRENT_PATH/src:$$CURRENT_PATH/out:$$PATH"
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslvar.bats tests/wslfetch.bats tests/wslview.bats
	
