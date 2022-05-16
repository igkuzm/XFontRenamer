/**
 * File              : FontRenamer.h
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 15.05.2022
 * Last Modified Date: 15.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface FontRenamer : NSObject
	//get font from url (good to scan files and dirs for fonts)
	+ (CGFontRef)fontFromURL:(NSURL *)url;

	//rename font and return callback
	+ (void)renameFont:(NSURL *)url font:(CGFontRef)font completionHandler:(void (^)(NSError *error, NSString *newPath))handler;

@end

// vim:ft=objc
