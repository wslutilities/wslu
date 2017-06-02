AUTOMAKE_OPTIONS = foreign
INSPATH=/usr/bin/
DOCPATH = /usr/share/doc/wslu
MANPATH = /usr/share/man/man1

all:
	@echo "wslu doesn't need to be built. Run \`make install' in order to install it."

install :
	install -m644 doc/* $(MANPATH)
	install bin/* $(INSPATH)

uninstall : 
	rm -f $(INSPATH)/wsl*
	rm -f $(MANPATH)/wsl*