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
INSTEDEXES := $(wildcard $(DESTDIR)/bin/wsl*)
INSTEDMANOS := $(wildcard $(DESTDIR)/share/man/man1/wsl*)

DATETMP = $(shell date +%Y-%m-%d)
VERTMP = $(shell grep 'version=' $(HEADER) | cut -d'=' -f 2 | xargs)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done
	chmod +x $(OUTPATH)/*

install: doc_install res_install
	install -Dm 755 out/* -t $(DESTDIR)/bin

uninstall: 
	for f in $(INSTEDEXES); do \
    	rm -f $$f; \
	done
	for f in $(INSTEDMANOS); do \
    	rm -f $$f; \
	done
	rm -rf $(DESTDIR)/share/man/man7/wslu.7.gz
	rm -rf /usr/share/wslu

doc:
	[ -d $(OUTMANPATH) ] || mkdir $(OUTMANPATH)
	for file in $(MANFILES); do \
    	cp $$file $(OUTMANPATH); \
    	sed -e 's/DATEPLACEHOLDER/'$(DATETMP)'/' -e 's/VERSIONPLACEHOLDER/'$(VERTMP)'/' $(OUTMANPATH)/`basename $$file` > $(OUTMANPATH)/`basename $$file`.tmp; \
		mv $(OUTMANPATH)/`basename $$file`.tmp $(OUTMANPATH)/`basename $$file`; \
		gzip -f -q $(OUTMANPATH)/`basename $$file`; \
	done

doc_install:
	install -Dm 555 out-docs/*.1.gz -t $(DESTDIR)/share/man/man1
	install -Dm 555 out-docs/*.7.gz -t $(DESTDIR)/share/man/man7

res_install:
	install -Dm 555 src/etc/* -t /usr/share/wslu

clean:
	rm -rf $(OUTPATH)
	rm -rf $(OUTMANPATH)

test:
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslvar.bats tests/wslfetch.bats tests/wslview.bats tests/wslact.bats tests/wslgsu.bats
