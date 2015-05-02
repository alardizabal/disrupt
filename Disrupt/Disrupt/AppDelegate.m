//
//  AppDelegate.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "AppDelegate.h"
#import "DTCreateProjectViewController.h"
#import "DTProjectDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  
  DTProjectDetailViewController *vc = [DTProjectDetailViewController new];
  self.window.rootViewController = vc;
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
