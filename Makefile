V=HEAD

PREFIX = /usr/local

BINPROGS = \
	remove-orphans

all: $(BINPROGS)

%:
	@echo "make $@"
	@cp "$@".in "$@"
	@chmod a-w "$@"
	@chmod +x "$@"

clean:
	rm -f $(BINPROGS)

install:
	install -dm0755 $(DESTDIR)$(PREFIX)/bin
	install -m0755 ${BINPROGS} $(DESTDIR)$(PREFIX)/bin

uninstall:
	for f in ${BINPROGS}; do rm -f $(DESTDIR)$(PREFIX)/bin/$$f; done

dist:
	git archive --format=tar --prefix=cromnix-utils-$(V)/ $(V) | gzip -9 > cromnix-utils-$(V).tar.gz
	gpg --detach-sign --use-agent cromnix-utils-$(V).tar.gz

.PHONY: all clean install uninstall dist

