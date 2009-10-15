#import "NSApplication_GESTURES.h"

@implementation NSApplication (GESTURES)

-(void)swizzledGestureEvent:(NSEvent *)anEvent
{
	BOOL didExecute = NO;
	if(anEvent.type	== 31) {//swipe
      //		NSLog(@"swipe");
		NSString *direction;
		if([anEvent deltaY] == 1) 
			direction = @"Up";
		else if([anEvent deltaY] == -1)
			direction = @"Down";
		else if([anEvent deltaX] == 1)
			direction = @"Left";
		else if([anEvent deltaX] == -1)
			direction = @"Right";
      
		didExecute = [[GestureShortcutsController sharedGestureShortcutsController] executeSwipe:@"Swipe" inDirection:direction];
	}
	else if(anEvent.type	== 30) {//zoom
		ExtendedGesturePoint * gesturePoint = [[ExtendedGesturePoint alloc] init];
      //		NSLog(@"Handling Zoom gesture.");
		gesturePoint.type = @"Zoom";
		gesturePoint.amount = [anEvent deltaZ];
		didExecute = [[GestureShortcutsController sharedGestureShortcutsController] addGesturePoint:gesturePoint];
		[gesturePoint release];
	}
	else if(anEvent.type	== 18) {//rotate
		ExtendedGesturePoint * gesturePoint = [[ExtendedGesturePoint alloc] init];
      //		NSLog(@"Handling Rotate gesture.");
		gesturePoint.type = @"Rotate";
		gesturePoint.amount = [anEvent rotation];
		didExecute = [[GestureShortcutsController sharedGestureShortcutsController] addGesturePoint:gesturePoint];
		[gesturePoint release];
	}
   //	else if(anEvent.type	== 19) {//disabled for now since - seems unneeded for our purposes and it creates overhead for two-finger scrolling
   //		NSLog(@"begin");
   //		[[GestureShortcutsController sharedGestureShortcutsController] beginExtendedGesture];
   //	}
	else if(anEvent.type == 20) {//end
      //		NSLog(@"Handling gesture end event.");
		didExecute = [[GestureShortcutsController sharedGestureShortcutsController] endExtendedGesture];
	}
	
	if(!didExecute) {
      //    NSLog(@"No binding found.  Using default implementation...");
		[self swizzledGestureEvent:anEvent]; //call the orginal implementation, which we swizzled out
	}
}


@end


