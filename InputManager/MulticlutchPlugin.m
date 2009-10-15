//
//  MulticlutchPlugin.m
//  InputManager
//
//  Created by Prashant Varanasi on 21/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MulticlutchPlugin.h"
#import <AppKit/AppKit.h>
#import <objc/runtime.h>
#import "GestureShortcutsController.h"


@implementation MulticlutchPlugin


/**
 * A special method called by SIMBL once the application has started and all classes are initialized.
 */
+ (void) load
{
   [MulticlutchPlugin sharedInstance];
   Method originalMethod = class_getInstanceMethod([NSApplication class], @selector(_handleGestureEvent:));
   Method replacedMethod = class_getInstanceMethod([NSApplication class], @selector(swizzledGestureEvent:));
   method_exchangeImplementations(originalMethod, replacedMethod);
//   NSLog(@"MulticlutchPlugin installed");
}

/**
 * @return the single static instance of the plugin object
 */
+ (MulticlutchPlugin*) sharedInstance
{
   static MulticlutchPlugin* plugin = nil;
   
   if (plugin == nil)
      plugin = [[MulticlutchPlugin alloc] init];
   
   return plugin;
}


@end
