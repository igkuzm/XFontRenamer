/**
 * File              : AppDelegate.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 15.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "AppDelegate.h"
#import "MainView.h"

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)notification {

	self.window = [[NSWindow alloc]initWithContentRect:NSMakeRect(0,0,300,200) styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:NO];

	self.window.frameAutosaveName=@"mainWindow";

	MainView *mainView = [[MainView alloc]initWithFrame:self.window.frame];
	self.view = mainView;
	[self.window setContentView:mainView];

	[self.window makeKeyAndOrderFront:NULL];

	NSLog(@"Application did finished lauching");
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed: (NSApplication *)sender {
	return true;
}

-(BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    NSLog(@"%@", filename);

	NSURL *url = [NSURL fileURLWithPath:filename];
	MainView *mainView = self.view;

	[mainView handleWithURL:url];
	[mainView showDone];

    return YES;
}

@end
