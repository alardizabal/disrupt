//
//  DTTask.h
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTUserModel.h"

@interface DTTask : NSObject
- (id)initWithJSONData:(NSDictionary *)jsonData;
@property (nonatomic, strong) DTUserModel *assignedUser;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *taskDescription;
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *estimate;
@end
