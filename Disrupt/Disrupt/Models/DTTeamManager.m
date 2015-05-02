//
//  DTTeamModel.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTTeamManager.h"

@implementation DTTeamManager

+ (instancetype)sharedManager {
  static DTTeamManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [DTTeamManager new];
  });
  return sharedInstance;
}

#pragma mark - Lazy initialization
- (NSMutableArray *)teamMembers {
  if (_teamMembers == nil) {
    _teamMembers = [NSMutableArray new];
  }
  return _teamMembers;
}

@end
