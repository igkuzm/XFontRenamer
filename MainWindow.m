/**
 * File              : MainWindow.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 14.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "MainWindow.h"

@implementation MainWindow
- (id)init
{
	if (self = [super initWithContentRect:NSMakeRect(0,0,680,460) styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled|NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO]) {
		
	}
	return self;
}

@end
