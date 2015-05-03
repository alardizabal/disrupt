//
//  DTTeamCollectionViewCell.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTTeamCollectionViewCell.h"

@implementation DTTeamCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.nameLabel];
  }
  return self;
}

#pragma mark - Layout
- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.nameLabel.frame = self.contentView.bounds;
}

#pragma mark - Lazy Initialization
- (UILabel *)nameLabel {
  if (_nameLabel == nil) {
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _nameLabel;
}

@end
