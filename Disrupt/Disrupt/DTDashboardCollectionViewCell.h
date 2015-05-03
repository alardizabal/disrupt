//
//  DTDashboardCollectionViewCell.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface DTDashboardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *projectCompletionLabel;

- (void)setProjectName:(NSString *)name;
- (void)setProjectPercentage:(NSNumber *)value;

@end