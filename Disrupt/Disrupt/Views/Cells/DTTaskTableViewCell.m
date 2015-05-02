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
    [self.contentView addSubview:self.taskTextField];
    [self.contentView addSubview:self.teamMemberLabel];
    self.backgroundColor = [UIColor blueColor];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGFloat fullWidth = CGRectGetWidth(self.contentView.bounds);
  
  CGFloat x = 0.0, y = 0.0, w = fullWidth * 0.7, h = CGRectGetHeight(self.contentView.bounds);
  self.taskTextField.frame = CGRectMake(x, y, w, h);
  
  x += w, w = fullWidth - w;
  self.teamMemberLabel.frame = CGRectMake(x, y, w, h);
}

- (UITextField *)taskTextField {
  if (_taskTextField == nil) {
    _taskTextField = [UITextField new];
    _taskTextField.placeholder = @"Enter a task...";
    _taskTextField.textColor = [UIColor whiteColor];
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 0.0)];
    [_taskTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_taskTextField setLeftView:indentView];
  }
  return _taskTextField;
}

- (UILabel *)teamMemberLabel {
  if (_teamMemberLabel == nil) {
    _teamMemberLabel = [UILabel new];
    _teamMemberLabel.textColor = [UIColor whiteColor];
    _teamMemberLabel.textAlignment = NSTextAlignmentCenter;
    _teamMemberLabel.text = @"Al";
  }
  return _teamMemberLabel;
}

@end
