//
//  DTProjectPreviewModel.h
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTProjectModel : NSObject
- (id)initWithJSONData:(NSDictionary *)jsonData;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSNumber *percentComplete;
@property (nonatomic, strong) NSMutableArray *projectTasks;
@end
