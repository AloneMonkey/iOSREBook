makefile:

CurrentDir = "$(shell pwd)"
ResourceDirecrory = AppSource
AppName = DemoApp
TmpBuildFile = $(AppName).app
ConstIBFile = Base.lproj
Architecture = arm64
CertificateName = "iPhone Developer: peiqing liu (xxxxxxxxxx)"

compile:
	#0、创建BuildDemo.app文件
	@rm -r -f $(TmpBuildFile)
	@test -d $(TmpBuildFile) || mkdir $(TmpBuildFile)

	#1、Compile Objective-C file
	@#如果不用xcrun直接用clang，需要用-isysroot指定系统SDK路径，如/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk

	@xcrun -sdk iphoneos clang \
		-arch $(Architecture) \
		-mios-version-min=8.0 \
		-fmodules \
		-fobjc-arc \
		-c $(ResourceDirecrory)/AppDelegate.m \
		-o $(TmpBuildFile)/AppDelegate.o

	@xcrun -sdk iphoneos clang -arch $(Architecture) -mios-version-min=8.0 -fmodules -fobjc-arc -c $(ResourceDirecrory)/main.m -o $(TmpBuildFile)/main.o
	@xcrun -sdk iphoneos clang -arch $(Architecture) -mios-version-min=8.0 -fmodules -fobjc-arc -c $(ResourceDirecrory)/ViewController.m -o $(TmpBuildFile)/ViewController.o
	
link:
	#2、Link Object file
	@xcrun -sdk iphoneos clang \
		$(TmpBuildFile)/main.o $(TmpBuildFile)/AppDelegate.o $(TmpBuildFile)/ViewController.o \
		-arch $(Architecture) \
		-mios-version-min=8.0 \
		-fobjc-arc \
		-fmodules \
		-o $(TmpBuildFile)/$(AppName)

	@rm $(TmpBuildFile)/AppDelegate.o $(TmpBuildFile)/main.o $(TmpBuildFile)/ViewController.o

storyboard:
	#3、编译storyboard文件
	@mkdir $(TmpBuildFile)/$(ConstIBFile)

	@ibtool \
		--compilation-directory \
		$(TmpBuildFile)/$(ConstIBFile) \
		$(ResourceDirecrory)/$(ConstIBFile)/Main.storyboard

	@ibtool --compilation-directory $(TmpBuildFile)/$(ConstIBFile) $(ResourceDirecrory)/$(ConstIBFile)/LaunchScreen.storyboard

plist:
	#4、plist : App ID、name、version ...
	
	@defaults write \
		$(CurrentDir)/$(TmpBuildFile)/Info \
		CFBundleDevelopmentRegion en #国际化时优先使用的语言

	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleExecutable $(AppName)
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleIdentifier com.alonemonkey.$(AppName)
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleInfoDictionaryVersion 6.0 #plist文件结构的版本
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleName $(AppName)
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundlePackageType APPL #APPL: app，FMWK: frameworks，BND: loadable bundles
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleShortVersionString 1.0
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info CFBundleVersion 1
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info LSRequiresIPhoneOS YES
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info UIMainStoryboardFile Main
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info UILaunchStoryboardName LaunchScreen
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info MinimumOSVersion 8.0
	@defaults write $(CurrentDir)/$(TmpBuildFile)/Info DTPlatformName iphoneos

asset:
	#5、复制图片资源
	@cp -a $(ResourceDirecrory)/images/. $(TmpBuildFile)/

dsym:
	#6、生成dSYM文件
	@#使用`dwarfdump --uuid `可以查看dSYM或可执行文件的UUID，匹配成功才能完全将crash log中的16进制地址符号化
	@dsymutil \
		-arch $(Architecture) \
		$(TmpBuildFile)/$(AppName) \
		-o $(AppName).app.dSYM

codesign:
	#7、签名
	@#mobileprovision文件包含Team ID和允许安装设备的ID
	@cp -f embedded.mobileprovision $(TmpBuildFile)
	@#provision查看命令：security cms -D -i provision_file

	@codesign \
		-fs \
		$(CertificateName) \
		--entitlements entitlements.plist \
		$(TmpBuildFile)
	@#使用codesign -vv xx.app 命令查看App签名信息

package:
	#8、打包ipa
	@mkdir -p Payload
	@cp -r -f $(TmpBuildFile) Payload
	@zip -r -q $(AppName).ipa Payload
	@rm -f -r Payload/
	@rm -f -r $(TmpBuildFile)


all: compile link storyboard plist asset dsym codesign package

