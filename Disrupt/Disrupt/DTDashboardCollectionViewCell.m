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
@property (nonatomic, strong) UILabel *projectCompletionLabel;
@end

@implementation DTDashboardCollectionViewCell


#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.backgroundColor = [UIColor yellowColor];
  [self.contentView addSubview:self.projectNameLabel];
  [self.contentView addSubview:self.projectCompletionLabel];
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat x, y, w, h = 0.0;
  x = 0.0, y = 0.0, w = CGRectGetWidth(self.contentView.bounds), h = CGRectGetHeight(self.contentView.bounds);
  self.projectNameLabel.frame = CGRectMake(0.0, 0.0, w, h);
  [self.projectCompletionLabel sizeToFit];
  w = CGRectGetWidth(self.projectCompletionLabel.bounds);
  x = CGRectGetWidth(self.contentView.bounds) - w;
  self.projectCompletionLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy Init

- (UILabel *)projectNameLabel {
  if (_projectNameLabel == nil) {
    _projectNameLabel = [UILabel new];
  }
  return _projectNameLabel;
}

-(UILabel *)projectCompletionLabel {
  if (_projectCompletionLabel == nil) {
    _projectCompletionLabel = [UILabel new];
  }
  return _projectCompletionLabel;
}

#pragma mark - Setters
- (void)setProjectName:(NSString *)name {
  _projectNameLabel.text = name;
}

- (void)setProjectPercentage:(NSNumber *)value {
  NSString *stringValue = value.stringValue;
  _projectCompletionLabel.text = [[NSString alloc] initWithFormat:@"%@%% Completed", stringValue];
  [self setNeedsLayout];
}

@end
