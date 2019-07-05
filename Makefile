VERSION = $(shell cat "VERSION")
PREFIX = zen
BIN = @zen
ZIP = zen
FLAGS = -i include -w unquoted-string -w redefinition-wo-undef
VERSION_FILES = README.md mod.cpp

MAJOR = $(word 1, $(subst ., ,$(VERSION)))
MINOR = $(word 2, $(subst ., ,$(VERSION)))
PATCH = $(word 3, $(subst ., ,$(VERSION)))
BUILD = $(word 4, $(subst ., ,$(VERSION)))
VERSION_S = $(MAJOR).$(MINOR).$(PATCH)
VERSION_F = $(MAJOR).$(MINOR).$(PATCH).$(BUILD)
GIT_HASH = $(shell git log -1 --pretty=format:"%H" | head -c 8)

ifeq ($(OS), Windows_NT)
	ARMAKE = ./tools/armake.exe # Downloaded via tools/getArmake.ps1
else
	ARMAKE = armake
endif

$(BIN)/addons/$(PREFIX)_%.pbo: addons/%
	@mkdir -p $(BIN)/addons
	@echo "  PBO  $@"
	@${ARMAKE} build ${FLAGS} -f -e "version=$(GIT_HASH)" $< $@

$(BIN)/optionals/$(PREFIX)_%.pbo: optionals/%
	@mkdir -p $(BIN)/optionals
	@echo "  PBO  $@"
	@${ARMAKE} build ${FLAGS} -f -e "version=$(GIT_HASH)" $< $@

# Shortcut for building single addons (eg. "make <component>.pbo")
%.pbo:
	"$(MAKE)" $(MAKEFLAGS) $(patsubst %, $(BIN)/addons/$(PREFIX)_%, $@)

all: $(patsubst addons/%, $(BIN)/addons/$(PREFIX)_%.pbo, $(wildcard addons/*)) \
		$(patsubst optionals/%, $(BIN)/optionals/$(PREFIX)_%.pbo, $(wildcard optionals/*))

filepatching:
	"$(MAKE)" $(MAKEFLAGS) FLAGS="-w unquoted-string -p"

$(BIN)/keys/%.biprivatekey:
	@mkdir -p $(BIN)/keys
	@echo "  KEY  $@"
	@${ARMAKE} keygen -f $(patsubst $(BIN)/keys/%.biprivatekey, $(BIN)/keys/%, $@)

$(BIN)/addons/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION)-$(GIT_HASH).bisign: $(BIN)/addons/$(PREFIX)_%.pbo $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey
	@echo "  SIG  $@"
	@${ARMAKE} sign -f -s $@ $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey $<

$(BIN)/optionals/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION)-$(GIT_HASH).bisign: $(BIN)/optionals/$(PREFIX)_%.pbo $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey
	@echo "  SIG  $@"
	@${ARMAKE} sign -f -s $@ $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey $<

signatures: $(patsubst addons/%, $(BIN)/addons/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION)-$(GIT_HASH).bisign, $(wildcard addons/*)) \
		$(patsubst optionals/%, $(BIN)/optionals/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION)-$(GIT_HASH).bisign, $(wildcard optionals/*))

version:
	@echo "  VER  $(VERSION)"
	$(shell sed -i -r -s 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/$(VERSION)/g' $(VERSION_FILES))
	$(shell sed -i -r -s 's/[0-9]+\.[0-9]+\.[0-9]+/$(VERSION_S)/g' $(VERSION_FILES))
	@printf "#define MAJOR $(MAJOR)%s\n#define MINOR $(MINOR)%s\n#define PATCHLVL $(PATCH)%s\n#define BUILD $(BUILD)%s\n" > "addons/main/script_version.hpp"

commit:
	@echo "  GIT  commit release preparation"
	@git add -A
	@git diff-index --quiet HEAD || git commit -am "Prepare release $(VERSION_S)" -q

push: commit
	@echo "  GIT  push release preparation"
	@git push -q

release: clean version commit
	@"$(MAKE)" $(MAKEFLAGS) signatures
	@echo "  ZIP  $(ZIP)_$(VERSION_F)-$(GIT_HASH).zip"
	@cp mod.cpp README.md AUTHORS.txt LICENSE logo_zen_ca.paa logo_zen_small_ca.paa $(BIN)
	@zip -qr $(ZIP)_$(VERSION_F)-$(GIT_HASH).zip $(BIN)

releaseCI: clean version
	@"$(MAKE)" $(MAKEFLAGS) signatures
	@echo "  TAR  $(ZIP)_$(VERSION_F)-$(GIT_HASH).tar.gz"
	@cp mod.cpp README.md AUTHORS.txt LICENSE logo_zen_ca.paa logo_zen_small_ca.paa $(BIN)
	@tar -czf $(ZIP)_$(VERSION_F)-$(GIT_HASH).tar.gz $(BIN)
	@ls

clean:
	rm -rf $(BIN) $(ZIP)_*.zip
	rm -rf $(BIN) $(ZIP)_*.tar.gz

.PHONY: all filepatching signatures version commit push release releaseCI clean
