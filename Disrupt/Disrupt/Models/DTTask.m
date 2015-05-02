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
    self.assignedUser = [[DTUserModel alloc] initWithJSONData:userData];
  }
  return self;
}
@end
