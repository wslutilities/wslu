AUTOMAKE_OPTIONS = foreign
INSPATH=/usr/bin/
DOCPATH = /usr/share/doc/wslu
MANPATH = /usr/share/man/man1

BIN := $(wildcard wsl*)

all:
	@echo "wslu doesn't need to be built. Run \`make install' in order to install it."

install :
	install -m644 doc/$(BIN) $(MANPATH)
	install bin/$(BIN) $(INSPATH)

uninstall : 
	rm -f $(INSPATH)/$(BIN)
	rm -f $(MANPATH)/$(BIN)