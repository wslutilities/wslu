AUTOMAKE_OPTIONS = foreign
HEADER = src/wslu-header
OUTPATH = out
CURPATH = $(shell pwd)

SOURCES := $(wildcard src/*.sh)
ETC := $(wildcard src/etc/*)
OUTFILES := $(wildcard out/*)
INSTEDEXES := $(wildcard /usr/bin/wsl*)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done
	chmod +x $(OUTPATH)/*

install:
	for file in $(OUTFILES); do \
		ln -s $(CURPATH)/$$file /usr/bin/`basename $$file`; \
	done
	[ -d /usr/lib/mime/packages ] || mkdir -p /usr/lib/mime/packages
	[ -d /usr/share/wslu ] || mkdir -p /usr/share/wslu
	cp src/etc/* /usr/share/wslu
	update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 10
	update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 10

uninstall: 
	for f in $(INSTEDEXES); do \
    	rm -f $$f; \
	done
	rm -rf /usr/share/wslu
	update-alternatives --remove x-www-browser /usr/bin/wslview
	update-alternatives --remove www-browser /usr/bin/wslview

clean:
	rm -rf $(OUTPATH)

test:
	PATH="$$CURRENT_PATH/src:$$CURRENT_PATH/out:$$PATH"
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslfetch.bats tests/wslview.bats
	
