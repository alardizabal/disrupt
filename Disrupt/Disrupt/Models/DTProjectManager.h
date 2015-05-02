//
//  DTTaskModel.h
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTProjectManager : NSObject

@property (nonatomic, strong) NSMutableArray *tasks;
+ (instancetype)sharedManager;

@end
