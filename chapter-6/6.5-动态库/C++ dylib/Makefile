CC = xcrun --sdk iphoneos clang++
ARCH = arm64
FRAMEWORK = -framework Foundation
VERSION = -compatibility_version 1 -current_version 1
VISIBLE = -fvisibility=hidden
TARGET = target.dylib

SOURCE = Person.mm

$(TARGET):$(SOURCE)
	$(CC) -dynamiclib -arch $(ARCH)  $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION)

.PHONY:clean
clean:
	rm $(TARGET)
