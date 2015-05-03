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
    [self addSubview:self.taskDesciptionTextView];
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
  self.taskDesciptionTextView.frame = CGRectMake(x, y, w, h);
  
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

- (UITextView *)taskDesciptionTextView {
  if (_taskDesciptionTextView == nil) {
    _taskDesciptionTextView = [UITextView new];
    _taskDesciptionTextView.backgroundColor = [UIColor clearColor];
    _taskDesciptionTextView.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskDesciptionTextView.textColor = [UIColor whiteColor];
    _taskDesciptionTextView.textContainerInset = UIEdgeInsetsMake(10.0, 20.0, 0.0, 0.0);
    _taskDesciptionTextView.textAlignment = NSTextAlignmentCenter;
  }
  return _taskDesciptionTextView;
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
