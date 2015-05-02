//
//  DTProjectDetailCollectionViewCell.m
//  Disrupt
//
//  Created by Albert Lardizabal on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectDetailCollectionViewCell.h"

static CGFloat const kDTHorizontalInset = 10.0;
static CGFloat const kDTMemberImageViewDiameter = 40.0;

@interface DTProjectDetailCollectionViewCell ()

@end

@implementation DTProjectDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.taskTitleLabel];
    [self.contentView addSubview:self.memberImageView];
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
  
  x = self.contentView.bounds.size.width - kDTHorizontalInset - kDTMemberImageViewDiameter,
  y = CGRectGetMidY(self.contentView.frame) - kDTMemberImageViewDiameter / 2.0,
  w = kDTMemberImageViewDiameter, h = kDTMemberImageViewDiameter;
  self.memberImageView.frame = CGRectMake(x, y, w, h);
}

- (UILabel *)numberLabel {
  if (_numberLabel == nil) {
    _numberLabel = [UILabel new];
  }
  return _numberLabel;
}

- (UILabel *)taskTitleLabel {
  if (_taskTitleLabel == nil) {
    _taskTitleLabel = [UILabel new];
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

@end
