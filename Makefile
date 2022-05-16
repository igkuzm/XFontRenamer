# File              : Makefile
# Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
# Date              : 25.08.2021
# Last Modified Date: 16.05.2022
# Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>

PROJECT_NAME=XFontRenamer

all: builddebug
	open build/Debug/$(PROJECT_NAME).app/Contents/MacOS/$(PROJECT_NAME)

builddebug:
	mkdir -p build && cd build && cmake .. -GXcode\
		-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk									
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj 

buildrelease: 
	mkdir -p build && cd build && cmake .. -GXcode\
		-DCMAKE_BUILD_TYPE=Release\
		-DCMAKECFLAGS=-fembed-bitcode -DCMAKECXX_FLAGS=-fembed-bitcode\
		-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk									
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj -configuration Release 

archive: buildrelease 
	xcodebuild -scheme $(PROJECT_NAME) -project build/$(PROJECT_NAME).xcodeproj -configuration Release archive -sdk macosx -archivePath build/$(PROJECT_NAME).xcarchive 
	open build/$(PROJECT_NAME).xcarchive

clean:
	rm -fr build

.Phony: clean builddebug buildrelease archive all
