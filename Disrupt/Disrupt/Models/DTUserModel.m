//
//  DTUserModel.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTUserModel.h"

@implementation DTUserModel
-(id)initWithJSONData:(NSDictionary *)jsonData {
  self = [super init];
  if (self) {
    self.userId = jsonData[@"id"];
    self.userName = jsonData[@"name"];
  }
  return self;
}
@end
