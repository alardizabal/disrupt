//
//  DTUserModel.h
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTUserModel : NSObject
- (id)initWithJSONData:(NSDictionary *)jsonData;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userId;
@end
