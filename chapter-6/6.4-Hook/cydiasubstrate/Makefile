export THEOS_DEVICE_IP=10.242.3.153
export THEOS_DEVICE_POST=22

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CydiaSubstrate
CydiaSubstrate_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MethodSwizzling"
