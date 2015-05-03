//
//  DTTaskTableViewCell.h
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTTaskTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *taskNumberLabel;
@property (nonatomic, strong) UITextView *taskDesciptionTextView;
@property (nonatomic, strong) UILabel *taskMemberLabel;

@end
