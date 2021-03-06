/**
 * File              : MainView.h
 * Author            : Igor V. Sementsov <ig.kuzm@gmail.com>
 * Date              : 14.05.2022
 * Last Modified Date: 17.05.2022
 * Last Modified By  : Igor V. Sementsov <ig.kuzm@gmail.com>
 */

#import <Cocoa/Cocoa.h>

@interface MainView : NSView
	@property  BOOL draggingCanceled;
	@property  BOOL renameDone;
	-(void)handleWithURL:(NSURL *)url;
	-(void)showDone;

@end

// vim:ft=objc
