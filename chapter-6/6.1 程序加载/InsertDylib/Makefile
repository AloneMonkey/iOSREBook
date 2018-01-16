CC = xcrun --sdk iphoneos clang
ARCH = arm64
FRAMEWORK = -framework Foundation
VERSION = -compatibility_version 1 -current_version 1
TARGET = InsertDylib.dylib
SOURCE = InsertDylib.mm

dylib:
	$(CC) -dynamiclib -arch $(ARCH) $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION) -install_name @executable_path/$(TARGET)

.PHONY:clean
clean:
	rm $(TARGET)


