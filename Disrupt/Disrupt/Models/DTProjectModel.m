//
//  DTProjectModel.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectModel.h"
#import "DTTask.h"

// This Model is used to store data about a project on the dashboard.
@implementation DTProjectModel
- (id)initWithJSONData:(NSDictionary *)jsonData {
  self = [super init];
  if (self) {
    self.projectId = jsonData[@"id"];
    self.projectName = jsonData[@"title"];
    NSArray *projectTasks = jsonData[@"tasks"];
    for (NSDictionary *taskData in projectTasks) {
      DTTask *dtTask = [[DTTask alloc] initWithJSONData:taskData];
      [self.projectTasks addObject:dtTask];
    }
    self.percentComplete = @50;
  }
  return self;
}
@end
