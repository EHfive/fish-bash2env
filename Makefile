
INSTALL ?= install
INSTALL_DATA ?= $(INSTALL) -m644
RM ?= rm -f
FISH ?= fish
FISH_FUNCTION_DIR ?= $(DESTDIR)/usr/share/fish/vendor_functions.d

all:

install:
	$(INSTALL_DATA) -Dt $(FISH_FUNCTION_DIR) functions/__bash2env.sh
	$(INSTALL_DATA) -Dt $(FISH_FUNCTION_DIR) functions/bash2env.fish

uninstall:
	$(RM) $(FISH_FUNCTION_DIR)/__bash2env.sh
	$(RM) $(FISH_FUNCTION_DIR)/bash2env.fish

test:
	$(FISH) -N test/escape.fish
	$(FISH) -N test/multiline.fish
	$(FISH) -N test/source.fish

.PHONY: install uninstall test
