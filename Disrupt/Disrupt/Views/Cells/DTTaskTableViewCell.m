//
//  DTTaskTableViewCell.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTTaskTableViewCell.h"

@implementation DTTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self addSubview:self.taskNumberLabel];
    [self addSubview:self.taskDescriptionTextView];
    [self addSubview:self.taskMemberLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:30/255.0f green:144/255.0f blue:255/255.0f alpha:1.0];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGFloat fullWidth = CGRectGetWidth(self.contentView.frame);
  
  CGFloat x = 0.0, y = 0.0, w = 50.0, h = CGRectGetHeight(self.contentView.frame);
  self.taskNumberLabel.frame = CGRectMake(x, y, w, h);
  
  x += w, w = fullWidth - 150.0;
  self.taskDescriptionTextView.frame = CGRectMake(x, y, w, h);
  
  x += w, w = 100.0;
  self.taskMemberLabel.frame = CGRectMake(x, y, w, h);
}

- (UILabel *)taskNumberLabel {
  if (_taskNumberLabel == nil) {
    _taskNumberLabel = [UILabel new];
    _taskNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskNumberLabel.textColor = [UIColor whiteColor];
    _taskNumberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskNumberLabel;
}

- (UITextView *)taskDescriptionTextView {
  if (_taskDescriptionTextView == nil) {
    _taskDescriptionTextView = [UITextView new];
    _taskDescriptionTextView.backgroundColor = [UIColor clearColor];
    _taskDescriptionTextView.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskDescriptionTextView.textColor = [UIColor whiteColor];
    _taskDescriptionTextView.textContainerInset = UIEdgeInsetsMake(10.0, 20.0, 0.0, 0.0);
    _taskDescriptionTextView.textAlignment = NSTextAlignmentCenter;
    _taskDescriptionTextView.tintColor = [UIColor colorWithRed:255.0/255.0 green:30.0/255.0 blue:144.0/255.0 alpha:1.0];
  }
  return _taskDescriptionTextView;
}

- (UILabel *)taskMemberLabel {
  if (_taskMemberLabel == nil) {
    _taskMemberLabel = [UILabel new];
    _taskMemberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskMemberLabel.textColor = [UIColor whiteColor];
    _taskMemberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskMemberLabel;
}

@end
