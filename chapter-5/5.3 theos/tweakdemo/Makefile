export THEOS_DEVICE_IP = localhost
export THEOS_DEVICE_PORT = 2222

export ARCHS = armv7 arm64
export TARGET = iphone:clang:latest:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TweakDemo
TweakDemo_FILES = Tweak.xm Manager.xm ZKSwizzle/ZKSwizzle.m
TweakDemo_CFLAGS = -fobjc-arc -Wno-int-to-void-pointer-cast -Wno-int-to-pointer-cast -I./BookLib/include -F./BookFramework
ZKSwizzle/ZKSwizzle.m_CFLAGS = -fno-objc-arc

TweakDemo_LDFLAGS = -L./BookLib -F./BookFramework
TweakDemo_LIBRARIES = BookLib
TweakDemo_FRAMEWORKS = BookFramework

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Snapchat"
