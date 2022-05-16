/**
 * File              : FontRenamer.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 15.05.2022
 * Last Modified Date: 15.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "FontRenamer.h"

@implementation FontRenamer

+ (CGFontRef)fontFromURL:(NSURL *)url{
	//get font from URL
	NSData *data = [NSData dataWithContentsOfURL:url];
	if (!data) {
		return NULL;
	}

	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);	
	if (!provider){
		return NULL;
	}	

	CGFontRef font = CGFontCreateWithDataProvider(provider);
	if (!font){
		return NULL;
	}

	return font;
}

+ (void)renameFont:(NSURL *)url font:(CGFontRef)font completionHandler:(void (^)(NSError *error, NSString *newPath))handler{
	// rename font and run callback

	CFStringRef fontName = CGFontCopyPostScriptName(font);
	if (!fontName){
		NSString *errorString = [NSString stringWithFormat:@"Font %@ at %@ has no name", font, url.path];
		NSError *error = [NSError errorWithDomain:@"FontRenamer" code:1 userInfo:@{@"error":errorString}];
		handler(error, NULL); //callback error
		return;
	}	

	NSString *name = (NSString*)fontName;
	NSString *extension = url.pathExtension;
	NSString *filename = url.lastPathComponent;
	NSString *path = [url URLByDeletingLastPathComponent].path;
	NSString *newPath = [NSString stringWithFormat:@"%@/%@.%@", path, name, extension];

	NSLog(@"Font name: %@", name);
	NSLog(@"Path: %@", newPath);

	NSError *error = nil;
	[[NSFileManager defaultManager] moveItemAtPath:url.path toPath:newPath error:&error];
	if (error){
		NSLog(@"ERROR: %@", error);
		handler(error, NULL); //callback error
	} else {
		// all is OK - return path with new font name
		handler(NULL, newPath);
	}	
}

@end
