/**
 * File              : MainView.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 15.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "MainView.h"
#include "FontRenamer.h"

@implementation MainView
- (id)initWithFrame:(NSRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable;
		[self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
		self.draggingCanceled = false;
	}
	return self;
}

//draw image on view
- (void)drawRect:(NSRect)dirtyRect {
    NSImage *image = [NSImage imageNamed:@"Dropzone"];
    [image drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1];
}

//make drag and drop
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
	NSLog(@"Dragging entred");
	//allow drop only for font files and directories that contains font files
	
	// check if file is font or directory
	__block BOOL isFont = false;
	for (NSPasteboardItem *item in sender.draggingPasteboard.pasteboardItems) {
		NSData *data = [item dataForType:@"public.file-url"]; 
		NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]];
		
		//check if url is directory
		BOOL isDir;
		BOOL exists = [[NSFileManager defaultManager]fileExistsAtPath:url.path isDirectory:&isDir];
		if (isDir){
			//find font
			NSArray *dirent = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:url.path error:NULL];
			[dirent enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
				//check if file
				NSString *filename = (NSString *)obj;
				NSString *path = [url.path stringByAppendingPathComponent:filename];
				NSLog(@"check path: %@", path);
				BOOL isDir;
				[[NSFileManager defaultManager]fileExistsAtPath:path isDirectory:&isDir];
				if (!isDir){
					NSURL *fileurl = [NSURL fileURLWithPath:path];
					if ([FontRenamer fontFromURL:fileurl]){
						isFont = true;
						*stop = true; //stop block	
					}	
				}	
			}];
		} else {
			if ([FontRenamer fontFromURL:url]) isFont = true;
		}	
	}	

	if (isFont){
		self.draggingCanceled = false;
		return NSDragOperationCopy;
	}	
	return NSDragOperationNone;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
	self.draggingCanceled = true;
	NSLog(@"Dagging exited");
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
	NSLog(@"Dragging ended: %@", self.draggingCanceled?@"Canceled":@"Accepted");
	if (!self.draggingCanceled){
		[self handleWithPasteboard:sender.draggingPasteboard];
		[self showDone];
	}	
}

-(void)handleWithPasteboard:(NSPasteboard *)pasteBoard{
	for (NSPasteboardItem *item in pasteBoard.pasteboardItems) {
		NSData *data = [item dataForType:@"public.file-url"]; 
		NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]];
		NSLog(@"%@", url.path);
		
		[self handleWithURL:url];
	}
}

-(void)handleWithURL:(NSURL *)url{
	//check if url is directory
	BOOL isDir;
	BOOL exists = [[NSFileManager defaultManager]fileExistsAtPath:url.path isDirectory:&isDir];
	if (exists && isDir){
		//handle with directory
		[self handleWithDirectory:url];

	} else {
		if (exists) {
			//handle with file
			[self handleWithFile:url];
		}
	}
}

-(void)handleWithDirectory:(NSURL *)url {
	NSArray *dirent = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:url.path error:NULL];
	[dirent enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
		//check if file
		NSString *filename = (NSString *)obj;
		NSString *path = [url.path stringByAppendingPathComponent:filename];
		NSLog(@"check path: %@", path);
		BOOL isDir;
		BOOL exists = [[NSFileManager defaultManager]fileExistsAtPath:path isDirectory:&isDir];
		if (!isDir){
			NSURL *fileurl = [NSURL fileURLWithPath:path];
			[self handleWithFile:fileurl];
		}	
	}];
}

-(void)handleWithFile:(NSURL *)url{
	CGFontRef font = [FontRenamer fontFromURL:url];
	if (font){
		[FontRenamer renameFont:url font:font completionHandler:^(NSError *error, NSString *newPath){
			if (error) {
				NSLog(@"ERROR: %@", error);
			} else {
				NSLog(@"Renamed font %@ to %@", url.path, newPath);
			}
		}];
	}	
}

-(void)showDone{
	NSAlert *alert = [[NSAlert alloc] init];
	alert.messageText=@"Done";
	//[alert setInformativeText:string];
	[alert addButtonWithTitle:@"OK"];
	
	[alert setAlertStyle:NSAlertStyleInformational];
	[alert beginSheetModalForWindow:[NSApp keyWindow] completionHandler:^(NSModalResponse returnCode) {
		if (returnCode == NSAlertFirstButtonReturn) {
			NSLog(@"Ok!");
			return;
		}
	}];	
}


@end
