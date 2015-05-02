//
//  DTProjectDetailCollectionViewCell.m
//  Disrupt
//
//  Created by Albert Lardizabal on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectDetailCollectionViewCell.h"

@interface DTProjectDetailCollectionViewCell ()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *taskTitleLabel;
@property (nonatomic, strong) UIImageView *memberImageView;

@end

@implementation DTProjectDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.taskTitleLabel];
    [self.contentView addSubview:self.memberImageView];
  }
  return self;
}

@end
