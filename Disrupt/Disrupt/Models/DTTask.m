//
//  DTTask.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTTask.h"

@implementation DTTask
- (id)initWithJSONData:(NSDictionary *)jsonData {
  self = [super init];
  if (self) {
    self.taskDescription = jsonData[@"description"];
    self.taskId = jsonData[@"id"];
    self.status = jsonData[@"status"];
    NSDictionary *userData = jsonData[@"user"];
    self.minutes = jsonData[@"minutes"];
    self.estimate = jsonData[@"estimate"];
    self.assignedUser = [[DTUserModel alloc] initWithJSONData:userData];
  }
  return self;
}

- (DTUserModel *)assignedUser {
  if (_assignedUser == nil) {
    _assignedUser = [DTUserModel new];
  }
  return _assignedUser;
}

@end
