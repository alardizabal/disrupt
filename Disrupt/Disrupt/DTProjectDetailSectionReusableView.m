//
//  DTProjectDetailSectionReusableView.m
//  Disrupt
//
//  Created by Albert Lardizabal on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectDetailSectionReusableView.h"

static const CGFloat kDTHorizontalPadding = 15.0;

@interface DTProjectDetailSectionReusableView ()

@end

@implementation DTProjectDetailSectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
//    self.backgroundColor = [UIColor colorWithRed:30/255.0f green:144/255.0f blue:255/255.0f alpha:1.0];
    self.backgroundColor = [UIColor grayColor];
    [self addSubview:self.sectionTitleLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGFloat x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  
  x = kDTHorizontalPadding, y = 0.0,
  w = self.bounds.size.width - kDTHorizontalPadding * 2, h = self.bounds.size.height;
  self.sectionTitleLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy Init
- (UILabel *)sectionTitleLabel {
  if (_sectionTitleLabel == nil) {
    _sectionTitleLabel = [UILabel new];
    _sectionTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12.0];
    _sectionTitleLabel.textColor = [UIColor whiteColor];
  }
  return _sectionTitleLabel;
}

@end
