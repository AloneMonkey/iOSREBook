CC = xcrun --sdk iphoneos clang
ARCH = arm64
FRAMEWORK = -framework Foundation
VERSION = -compatibility_version 1 -current_version 1 
EXPORT = -exported_symbols_list export_list
VISIBLE = -fvisibility=hidden
TARGET = target.dylib

SOURCE = Person.mm

target1:$(SOURCE1)
	$(CC) -dynamiclib -arch $(ARCH) $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION)

target2:$(SOURCE1)
	$(CC) -dynamiclib -arch $(ARCH) $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION) $(EXPORT)


target3:$(SOURCE1)
	$(CC) -dynamiclib -arch $(ARCH) $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION) $(VISIBLE)

clean:
	rm $(TARGET)