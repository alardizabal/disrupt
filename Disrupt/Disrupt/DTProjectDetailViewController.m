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
}

- (void)createStageArrays {
  
  NSMutableArray *inactiveArr = [NSMutableArray new];
  NSMutableArray *startedArr = [NSMutableArray new];
  NSMutableArray *reviewArr = [NSMutableArray new];
  NSMutableArray *doneArr = [NSMutableArray new];
  
  for (DTTask *task in self.project.projectTasks) {
    if ([task.status isEqualToString:@"non_started"]) {
      [inactiveArr addObject:task];
    } else if ([task.status isEqualToString:@"in_progress"]) {
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
  UIImage *leftButtonImage = [UIImage imageNamed:@"icon-arrow-left"];
  UIImage *leftButtonImagePressed = [UIImage imageNamed:@"icon-arrow-left"];
  UIButton *leftButton = [UIButton new];
  [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
  [leftButton setImage:leftButtonImagePressed forState:UIControlStateHighlighted];
  leftButton.frame = CGRectMake(0.0, 0.0, 10.0, 20.0);
  [leftButton addTarget:self action:@selector(tappedLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
  
  UIImage *rightButtonImage = [UIImage imageNamed:@"icon-send-airplane-normal"];
  UIImage *rightButtonImagePressed = [UIImage imageNamed:@"icon-send-airplane-selected"];
  UIButton *rightButton = [UIButton new];
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
    cell.taskTitleLabel.text = @"No tasks found.";
  } else {
    cell.taskTitleLabel.text = task.taskDescription;
  }
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  
  DTProjectDetailSectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTProjectDetailSectionReuseId forIndexPath:indexPath];
  
  NSString *statusString;
  if (indexPath.section == 0) {
    statusString = @"Not Yet Started";
  } else if (indexPath.section == 1) {
    statusString = @"In Progress";
  } else if (indexPath.section == 2) {
    statusString = @"Review";
  } else if (indexPath.section == 3) {
    statusString = @"Done";
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
  NSLog(@"tapped");
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tappedRightBarButton:(id)sender {
  NSLog(@"Tapped");
}

@end
