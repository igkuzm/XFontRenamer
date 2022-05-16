/**
 * File              : MainViewController.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 14.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "MainViewController.h"

@implementation MainViewController
- (id)initWithFrame:(NSRect)frame
{
	if (self = [super init]) {
		self.view = [[NSView alloc]initWithFrame:frame];
		self.view.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable;
	}
	return self;
}

@end
