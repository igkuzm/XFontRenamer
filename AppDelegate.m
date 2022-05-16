/**
 * File              : AppDelegate.m
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 17.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import "AppDelegate.h"
#import "MainView.h"

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)notification {

	NSLog(@"Application did finished lauching");
	
	//set main menu
	[self setupMainMenu];

	//set main window
	[self setupMainWindow];

}

-(void)setupMainWindow{
	if (!self.window || !self.window.isVisible) {
		self.window = [[NSWindow alloc]initWithContentRect:NSMakeRect(0,0,300,200) styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:NO];

		self.window.frameAutosaveName=@"mainWindow";

		MainView *mainView = [[MainView alloc]initWithFrame:self.window.frame];
		self.view = mainView;
		[self.window setContentView:mainView];
		[self.window makeKeyAndOrderFront:NULL];
	}
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed: (NSApplication *)sender {
	return false;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender  hasVisibleWindows:(BOOL)flag{
	if (!flag){
		[self.window setCollectionBehavior: NSWindowCollectionBehaviorMoveToActiveSpace];
		[NSApp activateIgnoringOtherApps:YES];
		//[self.window makeKeyAndOrderFront:nil];
		[self setupMainWindow];
		return TRUE;
	}
	return FALSE;
}

-(BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    NSLog(@"%@", filename);
	[self setupMainWindow];

	NSURL *url = [NSURL fileURLWithPath:filename];
	MainView *mainView = self.view;
	mainView.renameDone = false;

	[mainView handleWithURL:url];
	[mainView showDone];

    return YES;
}

-(void)setupMainMenu{
	NSMenu *mainMenu = [[NSMenu alloc]init];
	[NSApp setMainMenu:mainMenu];

	//Application menu
	NSMenuItem *appMenuItem = [[NSMenuItem alloc]init];
	[mainMenu addItem:appMenuItem];
	
	NSMenu *appMenu = [[NSMenu alloc]init];
	[appMenuItem setSubmenu:appMenu];

	[appMenu addItem:[[NSMenuItem alloc]initWithTitle:@"About XFontRenamer" action:@selector(about:) keyEquivalent:@""]];
	[appMenu addItem:[NSMenuItem separatorItem]];
	[appMenu addItem:[[NSMenuItem alloc]initWithTitle:@"Quit XFontRenamer" action:@selector(quit:) keyEquivalent:@"q"]];

	//Window menu
	NSMenuItem *windowMenuItem = [[NSMenuItem alloc]init];
	[mainMenu addItem:windowMenuItem];
	
	NSMenu *windowMenu = [[NSMenu alloc]init];
	windowMenu.title = @"Window";
	[windowMenuItem setSubmenu:windowMenu];

	[windowMenu addItem:[[NSMenuItem alloc]initWithTitle:@"Open Window" action:@selector(openWindow:) keyEquivalent:@"q"]];
	
}

-(void)quit:(id)sender{
	[NSApp terminate:sender];
}

-(void)about:(id)sender{
	[NSApp orderFrontStandardAboutPanel:NULL];
}

-(void)openWindow:(id)sender{
	[self setupMainWindow];
}

@end
