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
    self.backgroundColor = [UIColor dtPinkColor];
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
    _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:28.0];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _nameLabel;
}

- (void)setHighlighted:(BOOL)highlighted {
  if (highlighted) {
    self.nameLabel.textColor = [UIColor dtPinkColor];
    self.backgroundColor = [UIColor whiteColor];
  } else {
    self.nameLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor dtPinkColor];
  }
}

@end
