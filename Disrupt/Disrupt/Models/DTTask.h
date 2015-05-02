//
//  DTTask.h
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTask : NSObject

@property (nonatomic, strong) NSString *teamMember;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *taskDescription;

@end
