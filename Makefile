ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone:clang:9.3:7.0
#CFLAGS = -fobjc-arc
#THEOS_PACKAGE_DIR_NAME = debs

include theos/makefiles/common.mk

TWEAK_NAME = NoLockScreenCam
NoLockScreenCam_FILES = Tweak.xm
NoLockScreenCam_FRAMEWORKS = UIKit Foundation
NoLockScreenCam_LDFLAGS += -Wl,-segalign,4000
NoLockScreenCam_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += NoLockScreenCam
include $(THEOS_MAKE_PATH)/aggregate.mk
