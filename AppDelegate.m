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

	self.window = [[NSWindow alloc]initWithContentRect:NSMakeRect(0,0,300,200) styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:NO];

	self.window.frameAutosaveName=@"mainWindow";

	MainView *mainView = [[MainView alloc]initWithFrame:self.window.frame];
	self.view = mainView;
	[self.window setContentView:mainView];

	//set main menu
	[self setupMainMenu];

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
	mainView.renameDone = false;

	[mainView handleWithURL:url];
	[mainView showDone];

    return YES;
}

-(void)setupMainMenu{
	NSMenu *mainMenu = [[NSMenu alloc]init];
	[NSApp setMainMenu:mainMenu];

	NSMenuItem *appMenuItem = [[NSMenuItem alloc]init];
	appMenuItem.title = @"XFontRenamer";
	[mainMenu addItem:appMenuItem];
	
	NSMenu *appMenu = [[NSMenu alloc]init];
	[appMenuItem setSubmenu:appMenu];

	NSMenuItem *about = [[NSMenuItem alloc]init];
	about.title = @"About XFontRenamer";
	about.enabled = true;
	about.target = self;
	about.action = @selector(about:);	
	[appMenu addItem:about];

	[appMenu addItem:[NSMenuItem separatorItem]];

	NSMenuItem *quit = [[NSMenuItem alloc]init];
	quit.title = @"Quit XFontRenamer";
	quit.enabled = true;
	quit.target = self;
	quit.action = @selector(quit:);
	[appMenu addItem:quit];	

}

-(void)quit:(id)sender{
	[NSApp terminate:sender];
}

-(void)about:(id)sender{
	[NSApp orderFrontStandardAboutPanel:NULL];
}

@end
