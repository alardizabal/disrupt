//
//  DTTaskModel.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectManager.h"

@implementation DTProjectManager

+ (instancetype)sharedManager {
  static DTProjectManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [DTProjectManager new];
  });
  return sharedInstance;
}

#pragma mark - Lazy initialization
- (NSMutableArray *)tasks {
  if (_tasks == nil) {
    _tasks = [NSMutableArray new];
  }
  return _tasks;
}

@end
