AUTOMAKE_OPTIONS = foreign
HEADER = src/wslu-header
OUTPATH = out

SOURCES := $(wildcard src/*.sh)
ETC := $(wildcard src/etc/*)
OUTFILES := $(wildcard out/*)

all:
	[ -d $(OUTPATH) ] || mkdir $(OUTPATH)
	for file in $(SOURCES); do \
		cat $(HEADER) $$file > $(OUTPATH)/`basename $$file`; \
		mv $(OUTPATH)/`basename $$file` $(OUTPATH)/`basename $$file .sh`; \
	done
	chmod +x $(OUTPATH)/*

install:
	for file in $(OUTFILES); do \
		ln -s $(OUT)/$$file /usr/bin/`basename $$file`; \
	done
	cp src/mime/wslview /usr/lib/mime/packages/wslview
	update-mime
	[ -d /usr/share/wslu ] || mkdir -p /usr/share/wslu
	cp src/etc/* /usr/share/wslu
	update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 10
	update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 10

uninstall: 
	for f in /usr/bin/wsl*; do \
    	rm -f $$f; \
	done
	rm -rf /usr/share/wslu
	rm -f /usr/lib/mime/packages/wslview
	update-mime
	update-alternatives --remove x-www-browser /usr/bin/wslview
	update-alternatives --remove www-browser /usr/bin/wslview

clean:
	rm -rf $(OUTPATH)

test:
	PATH="$$CURRENT_PATH/src:$$CURRENT_PATH/out:$$PATH"
	extras/bats/libexec/bats tests/header.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslfetch.bats tests/wslview.bats
