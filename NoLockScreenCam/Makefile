ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone:clang:9.3:7.0
include theos/makefiles/common.mk

BUNDLE_NAME = NoLockScreenCam
NoLockScreenCam_FILES = NoLockScreenCam.mm
NoLockScreenCam_INSTALL_PATH = /Library/PreferenceBundles
NoLockScreenCam_FRAMEWORKS = UIKit
NoLockScreenCam_PRIVATE_FRAMEWORKS = Preferences
NoLockScreenCam_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoLockScreenCam.plist$(ECHO_END)
