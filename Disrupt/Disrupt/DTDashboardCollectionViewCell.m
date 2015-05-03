//
//  DTDashboardCollectionViewCell.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTDashboardCollectionViewCell.h"

static CGFloat const kDTDashCellSideMarginWidth = 10.0;

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
  self.contentView.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat x, y, w, h = 0.0;
  x = kDTDashCellSideMarginWidth, y = 0.0, w = CGRectGetWidth(self.contentView.bounds), h = CGRectGetHeight(self.contentView.bounds);
  self.projectNameLabel.frame = CGRectMake(x, 0.0, w, h);
  [self.projectCompletionLabel sizeToFit];
  w = CGRectGetWidth(self.projectCompletionLabel.bounds);
  x = CGRectGetWidth(self.contentView.bounds) - w - kDTDashCellSideMarginWidth;
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

#pragma mark - Code Tidiness Helpers
- (NSDictionary *) projectNameLabelAttributes {
  return @{
            NSFontAttributeName: [UIFont fontWithName:@"MarkerFelt-Wide" size:18]
          };
}

- (NSDictionary *) projectPercentLabelAttributes {
  return @{
           NSFontAttributeName: [UIFont fontWithName:@"MarkerFelt-Thin" size:14]
          };
}

#pragma mark - Setters
- (void)setProjectName:(NSString *)name {
  
  _projectNameLabel.attributedText = [[NSAttributedString alloc] initWithString:name attributes:[self projectNameLabelAttributes]];
}

- (void)setProjectPercentage:(NSNumber *)value {
  NSString *stringValue = value.stringValue;
  _projectCompletionLabel.attributedText = [[NSAttributedString alloc] initWithString: [[NSString alloc] initWithFormat:@"%@%% Completed", stringValue] attributes:[self projectPercentLabelAttributes]];
  [self setNeedsLayout];
}

@end
