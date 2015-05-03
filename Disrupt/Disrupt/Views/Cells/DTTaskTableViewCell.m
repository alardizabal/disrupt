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
    [self addSubview:self.taskTextView];
    [self addSubview:self.teamMemberLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor magentaColor];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGFloat fullWidth = CGRectGetWidth(self.contentView.frame);
  
  CGFloat x = 0.0, y = 0.0, w = fullWidth * 0.7, h = CGRectGetHeight(self.contentView.frame);
  self.taskTextView.frame = CGRectMake(x, y, w, h);
  
  x += w, w = fullWidth - w;
  self.teamMemberLabel.frame = CGRectMake(x, y, w, h);
}

- (UITextView *)taskTextView {
  if (_taskTextView == nil) {
    _taskTextView = [UITextView new];
    _taskTextView.backgroundColor = [UIColor clearColor];
    _taskTextView.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskTextView.textColor = [UIColor whiteColor];
    _taskTextView.textContainerInset = UIEdgeInsetsMake(10.0, 20.0, 0.0, 0.0);
  }
  return _taskTextView;
}

- (UILabel *)teamMemberLabel {
  if (_teamMemberLabel == nil) {
    _teamMemberLabel = [UILabel new];
    _teamMemberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _teamMemberLabel.textColor = [UIColor whiteColor];
    _teamMemberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _teamMemberLabel;
}

@end
