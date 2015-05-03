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
#import "DTDashboardViewController.h"
#import "DTCreateProjectViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  DTDashboardViewController *vc = [DTDashboardViewController new];
//  DTCreateProjectViewController *vc = [DTCreateProjectViewController new];
//  DTProjectDetailViewController *vc = [DTProjectDetailViewController new];

  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
  navController.navigationBar.translucent = NO;

  self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = navController;
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
