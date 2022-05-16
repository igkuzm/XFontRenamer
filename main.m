/**
 * File              : main.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 14.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, char *argv[])
{
	[NSApplication sharedApplication];
	[NSApp setDelegate:[[AppDelegate alloc]init]];
	[NSApp run];
	return 0;
}
