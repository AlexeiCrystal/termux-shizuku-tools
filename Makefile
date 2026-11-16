# Required tools: curl, unzip, sha256sum
#
#   make            fetch + install the dex
#   make verify     fetch and check the dex without installing it
#   make package    install the dex, then run build.sh to produce the .deb
#   make clean      remove .build/, the installed dex and the .deb

SHIZUKU_NEXT_VERSION    := v14.0.33-next
SHIZUKU_NEXT_REPO       := rushiranpise/Shizuku-Next
SHIZUKU_NEXT_APK        := shizuku-$(SHIZUKU_NEXT_VERSION).apk
SHIZUKU_NEXT_APK_SHA256 := 1275bb1df8b3bdabb9d5f8f60c83da01e29ccb621281449efcbbb6b196875726
SHIZUKU_NEXT_URL        := https://github.com/$(SHIZUKU_NEXT_REPO)/releases/download/$(SHIZUKU_NEXT_VERSION)/$(SHIZUKU_NEXT_APK)

# Where the dex sits in the release APK, and what it must hash to.
DEX_ASSET  := assets/rish_shizuku.dex
DEX_SHA256 := d199c325ec3d77ac677e1d9985637422f00c3990a1a79d60081ec4100d232d88

DEX_FILE := termux-shizuku-tools/data/data/com.termux/files/usr/libexec/shizuku/rish_shizuku.dex
DEB      := termux-shizuku-tools.deb

BUILD_DIR := .build
APK       := $(BUILD_DIR)/$(SHIZUKU_NEXT_APK)
RAW_DEX   := $(BUILD_DIR)/rish_shizuku.dex

.PHONY: all dex verify package clean help

all: dex

help:
	@echo 'make            fetch (once) and install the dex into the package tree'
	@echo 'make verify     fetch and check the dex without installing it'
	@echo 'make package    install the dex, then run build.sh'
	@echo 'make clean      remove .build/, the installed dex and the .deb'

$(APK):
	@mkdir -p $(BUILD_DIR)
	@echo 'Fetching $(SHIZUKU_NEXT_APK) ...'
	@rm -f $@.part
	curl -fL --retry 3 --proto '=https' -o $@.part '$(SHIZUKU_NEXT_URL)'
	@printf '%s  %s\n' '$(SHIZUKU_NEXT_APK_SHA256)' '$@.part' | sha256sum -c -
	@mv $@.part $@

$(RAW_DEX): $(APK)
	@unzip -p $< '$(DEX_ASSET)' > $@.part
	@printf '%s  %s\n' '$(DEX_SHA256)' '$@.part' | sha256sum -c -
	@mv $@.part $@

$(DEX_FILE): $(RAW_DEX)
	@mkdir -p $(dir $@)
	cp $< $@.part
	mv $@.part $@
	chmod 644 $@

dex: $(DEX_FILE)
	@echo "Installed $(DEX_FILE)"

verify: $(RAW_DEX)
	@printf '%s  %s\n' '$(DEX_SHA256)' '$(RAW_DEX)' | sha256sum -c -
	@echo "Verified $(RAW_DEX)"

package: dex
	bash ./build.sh

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(DEX_FILE) $(DEB)
