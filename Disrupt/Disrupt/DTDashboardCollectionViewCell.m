//
//  DTDashboardCollectionViewCell.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTDashboardCollectionViewCell.h"

static CGFloat const kDTDashCellSideMarginWidth = 20.0;

@interface DTDashboardCollectionViewCell ()

@property (nonatomic, strong) UILabel *projectNameLabel;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation DTDashboardCollectionViewCell

#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.contentView.backgroundColor = [UIColor grayColor];
  [self.contentView addSubview:self.projectNameLabel];
  [self.contentView addSubview:self.projectCompletionLabel];
  [self.contentView addSubview:self.separatorView];
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat fullWidth = CGRectGetWidth(self.contentView.bounds),
  fullHeight = CGRectGetHeight(self.contentView.bounds);
  
  CGFloat x, y, w, h = 0.0;
  x = kDTDashCellSideMarginWidth, y = 0.0, w = fullWidth, h = fullHeight;
  self.projectNameLabel.frame = CGRectMake(x, 0.0, w, h);
  
  y = -4.0,
  w = CGRectGetWidth(self.projectCompletionLabel.bounds);
  x = fullWidth - 75.0 - kDTDashCellSideMarginWidth;
  self.projectCompletionLabel.frame = CGRectMake(x, y, 80.0, h);
  
  x = 0.0, y = CGRectGetMaxY(self.contentView.frame) - 2.0;
  w = self.contentView.bounds.size.width, h = 2.0;
  self.separatorView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy Init

- (UILabel *)projectNameLabel {
  if (_projectNameLabel == nil) {
    _projectNameLabel = [UILabel new];
    _projectNameLabel.textColor = [UIColor whiteColor];
  }
  return _projectNameLabel;
}

-(UILabel *)projectCompletionLabel {
  if (_projectCompletionLabel == nil) {
    _projectCompletionLabel = [UILabel new];
    _projectCompletionLabel.textColor = [UIColor whiteColor];
    _projectCompletionLabel.textAlignment = NSTextAlignmentCenter;
    _projectCompletionLabel.numberOfLines = 2;
  }
  return _projectCompletionLabel;
}

- (UIView *)separatorView {
  if (_separatorView == nil) {
    _separatorView = [UIView new];
    _separatorView.backgroundColor = [UIColor whiteColor];
  }
  return _separatorView;
}

#pragma mark - Code Tidiness Helpers
- (NSDictionary *) projectNameLabelAttributes {
  return @{
            NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:28.0]
          };
}

- (NSDictionary *) projectPercentLabelAttributes {
  return @{
           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:28.0]
          };
}

#pragma mark - Setters
- (void)setProjectName:(NSString *)name {
  if (name == nil) {
    name = @"UNNAMED";
  }
  NSString *projectName = [name uppercaseString];
  _projectNameLabel.attributedText = [[NSAttributedString alloc] initWithString:projectName attributes:[self projectNameLabelAttributes]];
}

- (void)setHighlighted:(BOOL)highlighted {
  if (highlighted) {
    self.contentView.backgroundColor = [UIColor lightGrayColor];
  } else {
    self.contentView.backgroundColor = [UIColor grayColor];
  }
}

@end
