//
//  DTDashboardCollectionViewCell.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTDashboardCollectionViewCell.h"

@interface DTDashboardCollectionViewCell ()
@property (nonatomic, strong) UILabel *projectNameLabel;
@end

@implementation DTDashboardCollectionViewCell


#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.backgroundColor = [UIColor yellowColor];
  [self.contentView addSubview:self.projectNameLabel];
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - Lazy Init

- (UILabel *)projectNameLabel {
  if (_projectNameLabel == nil) {
    _projectNameLabel = [UILabel new];
    _projectNameLabel.text = @"TEST";
  }
  return _projectNameLabel;
}

@end
