//
//  RPAppDelegate.m
//  Example
//
//  Created by Rui Peres on 11/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPAppDelegate.h"
#import "RPExampleViewController.h"

@implementation RPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[RPExampleViewController alloc] init];
    
    return YES;
}

@end
