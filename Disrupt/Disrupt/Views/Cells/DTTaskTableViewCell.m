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
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.taskTextField.frame = self.contentView.bounds;
}

- (UITextField *)taskTextField {
  if (_taskTextField == nil) {
    _taskTextField = [UITextField new];
    _taskTextField.placeholder = @"Enter a task...";
    _taskTextField.textColor = [UIColor whiteColor];
    _taskTextField.backgroundColor = [UIColor blueColor];
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 0.0)];
    [_taskTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_taskTextField setLeftView:indentView];
  }
  return _taskTextField;
}

@end
