//
//  DTProjectDetailCollectionViewCell.m
//  Disrupt
//
//  Created by Albert Lardizabal on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectDetailCollectionViewCell.h"

static CGFloat const kDTPhotoBorderWidth = 1.0;
static CGFloat const kDTHorizontalInset = 20.0;
static CGFloat const kDTMemberImageViewDiameter = 40.0;

@interface DTProjectDetailCollectionViewCell ()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIView *memberBackgroundView;

@end

@implementation DTProjectDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.taskTitleLabel];
    [self.contentView addSubview:self.memberBackgroundView];
    [self.memberBackgroundView addSubview:self.memberImageView];
    [self.contentView addSubview:self.separatorView];
  }
  return self;
}

- (void)prepareForReuse {
  
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGFloat x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  
  x = kDTHorizontalInset, y = 0.0,
  w = 10.0, h = self.contentView.frame.size.height;
  self.numberLabel.frame = CGRectMake(x, y, w, h);
  
  x += 25.0, w = self.contentView.bounds.size.width - kDTMemberImageViewDiameter - x;
  self.taskTitleLabel.frame = CGRectMake(x, y, w, h);
  
  x = self.contentView.bounds.size.width - kDTHorizontalInset - kDTMemberImageViewDiameter - kDTPhotoBorderWidth * 2.0,
  y = CGRectGetMidY(self.contentView.frame) - (kDTMemberImageViewDiameter - kDTPhotoBorderWidth) / 2.0,
  w = kDTMemberImageViewDiameter + kDTPhotoBorderWidth * 2.0,
  h = w;
  self.memberBackgroundView.frame = CGRectMake(x, y, w, h);
  
  x = kDTPhotoBorderWidth, y = kDTPhotoBorderWidth,
  w = kDTMemberImageViewDiameter, h = w;
  self.memberImageView.frame = CGRectMake(x, y, w, h);
  
  x = 0.0, y = CGRectGetMaxY(self.contentView.frame) - 1.0;
  w = self.contentView.bounds.size.width, h = 1.0;
  self.separatorView.frame = CGRectMake(x, y, w, h);
}

- (UILabel *)numberLabel {
  if (_numberLabel == nil) {
    _numberLabel = [UILabel new];
    _numberLabel.alpha = 0.88;
    _numberLabel.font = [UIFont boldSystemFontOfSize:14.0];
  }
  return _numberLabel;
}

- (UILabel *)taskTitleLabel {
  if (_taskTitleLabel == nil) {
    _taskTitleLabel = [UILabel new];
    _taskTitleLabel.alpha = 0.78;
    _taskTitleLabel.font = [UIFont boldSystemFontOfSize:14.0];
  }
  return _taskTitleLabel;
}

- (UIImageView *)memberImageView {
  if (_memberImageView == nil) {
    _memberImageView = [UIImageView new];
    _memberImageView.image = [UIImage imageNamed:@"Al"];
    _memberImageView.layer.cornerRadius = kDTMemberImageViewDiameter / 2.0;
    _memberImageView.contentMode = UIViewContentModeScaleAspectFill;
    _memberImageView.clipsToBounds = YES;
  }
  return _memberImageView;
}

- (UIView *)memberBackgroundView {
  if (_memberBackgroundView == nil) {
    _memberBackgroundView = [UIView new];
    _memberBackgroundView.backgroundColor = [UIColor whiteColor];
    _memberBackgroundView.layer.cornerRadius = (kDTMemberImageViewDiameter + kDTPhotoBorderWidth * 2.0) / 2.0;
  }
  return _memberBackgroundView;
}

- (UIView *)separatorView {
  if (_separatorView == nil) {
    _separatorView = [UIView new];
    _separatorView.backgroundColor = [UIColor blackColor];
    _separatorView.alpha = 0.25;
  }
  return _separatorView;
}

@end
