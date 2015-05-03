//
//  DTTeamCollectionViewCell.h
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTUserModel.h"

@interface DTTeamCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DTUserModel *user;
@end
