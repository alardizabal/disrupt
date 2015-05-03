//
//  DTProjectDetailViewController.m
//  Disrupt
//
//  Created by Albert Lardizabal on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTProjectDetailViewController.h"
#import "DTProjectDetailCollectionViewCell.h"
#import "DTProjectDetailSectionReusableView.h"
#import "DTTask.h"
#import <AFNetworking/AFNetworking.h>

static CGFloat const kDTCollectionViewCellHeight = 60.0;

static NSString * const kDTProjectDetailCellReuseId = @"_dt.reuse.projectDetailCell";
static NSString * const kDTProjectDetailSectionReuseId = @"_dt.reuse.projectDetailSection";

@interface DTProjectDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *inactiveArray;
@property (nonatomic, strong) NSArray *startedArray;
@property (nonatomic, strong) NSArray *reviewArray;
@property (nonatomic, strong) NSArray *doneArray;

@end

@implementation DTProjectDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = self.project.projectName;
  
  [self.view addSubview:self.collectionView];
  
  [self setupNavBar];
  [self createStageArrays];
}

- (void)createStageArrays {
  
  NSMutableArray *inactiveArr = [NSMutableArray new];
  NSMutableArray *startedArr = [NSMutableArray new];
  NSMutableArray *reviewArr = [NSMutableArray new];
  NSMutableArray *doneArr = [NSMutableArray new];
  
  for (DTTask *task in self.project.projectTasks) {
    if ([task.status isEqualToString:@"inactive"]) {
      [inactiveArr addObject:task];
    } else if ([task.status isEqualToString:@"started"]) {
      [startedArr addObject:task];
    } else if ([task.status isEqualToString:@"review"]) {
      [reviewArr addObject:task];
    } else if ([task.status isEqualToString:@"done"]) {
      [doneArr addObject:task];
    }
  }
  
  self.inactiveArray = inactiveArr;
  self.startedArray = startedArr;
  self.reviewArray = reviewArr;
  self.doneArray = doneArr;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  CGFloat x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  
  x = 0.0, y = -10.0, w = self.view.bounds.size.width, h = self.view.bounds.size.height + 10.0;
  self.collectionView.frame = CGRectMake(x, y, w, h);
}

- (void)setupNavBar {
  
//  theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//  [theImageView setTintColor:[UIColor redColor]];
  
  UIImage *leftButtonImage = [[UIImage imageNamed:@"icon-arrow-left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *leftButtonImagePressed = [UIImage imageNamed:@"icon-arrow-left"];
  UIButton *leftButton = [UIButton new];
  leftButton.tintColor = [UIColor whiteColor];
  [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
  [leftButton setImage:leftButtonImagePressed forState:UIControlStateHighlighted];
  leftButton.frame = CGRectMake(0.0, 0.0, 10.0, 20.0);
  [leftButton addTarget:self action:@selector(tappedLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
  
  UIImage *rightButtonImage = [[UIImage imageNamed:@"icon-send-airplane-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *rightButtonImagePressed = [UIImage imageNamed:@"icon-send-airplane-selected"];
  UIButton *rightButton = [UIButton new];
  rightButton.tintColor = [UIColor whiteColor];
  [rightButton setImage:rightButtonImage forState:UIControlStateNormal];
  [rightButton setImage:rightButtonImagePressed forState:UIControlStateHighlighted];
  rightButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
  [rightButton addTarget:self action:@selector(tappedRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - Lazy init

- (UICollectionView *)collectionView {
  if (_collectionView == nil) {
    _collectionView =
    [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[DTProjectDetailCollectionViewCell class]
        forCellWithReuseIdentifier:kDTProjectDetailCellReuseId];
    [_collectionView registerClass:[DTProjectDetailSectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTProjectDetailSectionReuseId];
    _collectionView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
  }
  return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
  if (_flowLayout == nil) {
    _flowLayout = [UICollectionViewFlowLayout new];
  }
  return _flowLayout;
}

#pragma mark - Collection View Delegates
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  DTProjectDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDTProjectDetailCellReuseId forIndexPath:indexPath];
  
//  cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
//  cell.taskTitleLabel.text = @"This is a title text label.";
//  DTTask *task = self.project.projectTasks[indexPath.row];
//  cell.taskTitleLabel.text = task.taskDescription;
  
  BOOL isEmptyState = NO;
  DTTask *task = nil;
  
  if (indexPath.section == 0) {
    if (self.inactiveArray.count == 0) {
      isEmptyState = YES;
    } else {
      task = self.inactiveArray[indexPath.row];
    }
  } else if (indexPath.section == 1) {
    if (self.startedArray.count == 0) {
      isEmptyState = YES;
    } else {
      task = self.startedArray[indexPath.row];
    }
  } else if (indexPath.section == 2) {
    if (self.reviewArray.count == 0) {
      isEmptyState = YES;
    } else {
      task = self.reviewArray[indexPath.row];
    }
  } else if (indexPath.section == 3) {
    if (self.doneArray.count == 0) {
      isEmptyState = YES;
    } else {
      task = self.doneArray[indexPath.row];
    }
  }
  
  if (isEmptyState == YES) {
    cell.taskTitleLabel.alpha = 0.3;
    cell.taskTitleLabel.text = @"No tasks found.";
    cell.memberBackgroundView.hidden = YES;
    cell.timeLabel.hidden = YES;
  } else {
    
    cell.timeLabel.hidden = NO;
    
    NSString *minutesString = nil;
    NSString *estimateString = nil;
    
    if ([task.minutes integerValue] >= 60) {
      NSInteger hours = [task.minutes integerValue] / 60;
      NSInteger minutes = [task.minutes integerValue] % 60;
      
      if (minutes == 0) {
        minutesString = [NSString stringWithFormat:@"%ldh", (long)hours];
      } else {
        minutesString = [NSString stringWithFormat:@"%ldh%ldm", (long)hours, (long)minutes];
      }
    } else {
      minutesString = [NSString stringWithFormat:@"%ldm", [task.minutes integerValue]];
    }
    
    if ([task.estimate integerValue] >= 60) {
      NSInteger hours = [task.estimate integerValue] / 60;
      NSInteger minutes = [task.minutes integerValue] % 60;
      
      if (minutes == 0) {
        estimateString = [NSString stringWithFormat:@"%ldh", (long)hours];
      } else {
        estimateString = [NSString stringWithFormat:@"%ldh%ldm", (long)hours, (long)minutes];
      }
    } else {
      estimateString = [NSString stringWithFormat:@"%ldm", [task.estimate integerValue]];
    }
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@/%@", minutesString, estimateString];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.taskTitleLabel.alpha = 0.72;
    cell.taskTitleLabel.text = task.taskDescription;
    
    UIImage *assignedUserImage = nil;
    if ([task.assignedUser.userName isEqualToString:@"Al"]) {
      assignedUserImage = [UIImage imageNamed:@"Al"];
    } else if ([task.assignedUser.userName isEqualToString:@"Danny"]) {
      assignedUserImage = [UIImage imageNamed:@"Danny"];
    } else if ([task.assignedUser.userName isEqualToString:@"Rich"]) {
      assignedUserImage = [UIImage imageNamed:@"Rich"];
    } else if ([task.assignedUser.userName isEqualToString:@"Kevin"]) {
      assignedUserImage = [UIImage imageNamed:@"Kevin"];
    }
    cell.memberBackgroundView.hidden = NO;
    cell.memberImageView.image = assignedUserImage;
  }
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  
  DTProjectDetailSectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTProjectDetailSectionReuseId forIndexPath:indexPath];
  
  NSString *statusString;
  if (indexPath.section == 0) {
    statusString = @"NOT YET STARTED";
  } else if (indexPath.section == 1) {
    statusString = @"IN PROGRESS";
  } else if (indexPath.section == 2) {
    statusString = @"REVIEW";
  } else if (indexPath.section == 3) {
    statusString = @"DONE";
  }
  
  header.sectionTitleLabel.text = statusString;
  
  return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(self.view.frame.size.width, 20.0);
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (section == 0) {
    if (self.inactiveArray.count == 0) {
      return 1;
    } else {
      return self.inactiveArray.count;
    }
  } else if (section == 1) {
    if (self.startedArray.count == 0) {
      return 1; 
    } else {
      return self.startedArray.count;
    }
  } else if (section == 2) {
    if (self.reviewArray.count == 0) {
      return 1;
    } else {
      return self.reviewArray.count;
    }
  } else if (section == 3) {
    if (self.doneArray.count == 0) {
      return 1;
    } else {
      return self.doneArray.count;
    }
  }
  return 1;
//  return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 4;
}

#pragma mark - Collection View Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(CGRectGetWidth(self.view.bounds), kDTCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0.0;
}

#pragma mark - Actions

- (void)tappedLeftBarButton:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tappedRightBarButton:(id)sender {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //projects/:id/send_project_status
  NSMutableString *URLString = [[NSMutableString alloc] initWithString:@"http://api.localhost.local:3040/projects/"];
  [URLString appendString:self.project.projectId];
  [URLString appendString:@"/send_project_status"];
  NSLog(@"%@", URLString);
  [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"YAEAAAAH");
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"nooooO!");
  }];
}

@end
