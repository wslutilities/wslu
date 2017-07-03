AUTOMAKE_OPTIONS = foreign
INSPATH=/usr/bin
DOCPATH = /usr/share/doc/wslu
MANPATH = /usr/share/man/man1

BIN := $(wildcard wsl*)
MAN := $(wildcard docs/*.1)
SBIN := $(wildcard $(INSPATH)/wsl*)
SMAN := $(wildcard $(MANPATH)/*.1)
all:
	@echo "wslu doesn't need to be built. Run 'sudo make install' to install it."

install :
	install -m644 $(MAN) $(MANPATH)
	install $(BIN) $(INSPATH)
	sudo apt-get install -y bc

uninstall : 
	rm -f $(SBIN)
	rm -f $(SMAN)
