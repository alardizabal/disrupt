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
    [self addSubview:self.taskTextField];
  }
  return self;
}

- (void)layoutSubviews {
  self.taskTextField.frame = self.frame;
}

- (UITextField *)taskTextField {
  if (_taskTextField == nil) {
    _taskTextField = [UITextField new];
    _taskTextField.backgroundColor = [UIColor yellowColor];
    _taskTextField.placeholder = @"Enter a task...";
  }
  return _taskTextField;
}

@end
