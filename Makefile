AUTOMAKE_OPTIONS = foreign
HEADER = src/wslu-header
OUTPATH = out
MANPATH = docs
OUTMANPATH = out-docs
CURPATH = $(shell pwd)

SOURCES := $(wildcard src/*.sh)
ETCFILES := $(wildcard src/etc/*)
OUTFILES := $(wildcard out/*)
MANFILES := $(wildcard docs/*)
INSTEDEXES := $(wildcard /usr/bin/wsl*)
INSTEDMANS := $(wildcard /usr/share/man/man1/wsl*)

DATETMP = $(shell date +%Y-%m-%d)
VERTMP = $(shell grep 'version=' $(HEADER) | cut -d'=' -f 2 | xargs)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done
	chmod +x $(OUTPATH)/*

install:
	install -Dm 555 out-docs/* -t $(DESTDIR)/share/man/man1
	install -Dm 755 out/* -t $(DESTDIR)/bin
	install -Dm 555 src/etc/* -t /usr/share/wslu

uninstall: 
	for f in $(INSTEDEXES); do \
    	rm -f $$f; \
	done
	for f in $(INSTEDMANS); do \
    	rm -f $$f; \
	done
	rm -rf /usr/share/wslu

doc:
	[ -d $(OUTMANPATH) ] || mkdir $(OUTMANPATH)
	for file in $(MANFILES); do \
    	cp $$file $(OUTMANPATH); \
    	sed -e 's/DATEPLACEHOLDER/'$(DATETMP)'/' -e 's/VERSIONPLACEHOLDER/'$(VERTMP)'/' $(OUTMANPATH)/`basename $$file` > $(OUTMANPATH)/`basename $$file`.tmp; \
		mv $(OUTMANPATH)/`basename $$file`.tmp $(OUTMANPATH)/`basename $$file`; \
		gzip -f -q $(OUTMANPATH)/`basename $$file`; \
	done

res:
	install -Dm 555 src/etc/* -t /usr/share/wslu

clean:
	rm -rf $(OUTPATH)
	rm -rf $(OUTMANPATH)

test:
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslvar.bats tests/wslfetch.bats tests/wslview.bats tests/wslact.bats
