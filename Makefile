# File              : Makefile
# Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
# Date              : 25.08.2021
# Last Modified Date: 17.05.2022
# Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>

PROJECT_NAME=XFontRenamer

all: build/Debug
	open build/Debug/$(PROJECT_NAME).app/Contents/MacOS/$(PROJECT_NAME)

build/Debug: *.m *.h *.plist *.entitlements
	mkdir -p build && cd build && cmake .. -GXcode\
		-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk									
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj 

build/Release: *.m *.h *.plist *.entitlements
	mkdir -p build && cd build && cmake .. -GXcode\
		-DCMAKE_BUILD_TYPE=Release\
		-DCMAKECFLAGS=-fembed-bitcode -DCMAKECXX_FLAGS=-fembed-bitcode\
		-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk									
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj -configuration Release 

archive: build/Release 
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj -configuration Release archive -sdk macosx -archivePath build/$(PROJECT_NAME).xcarchive 
	open build/$(PROJECT_NAME).xcarchive

dmg: build/Release
	hdiutil create build/$(PROJECT_NAME).dmg -volname "$(PROJECT_NAME)" -fs HFS+ -srcfolder "build/Release"

clean:
	rm -fr build

.Phony: clean archive dmg all
