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

static CGFloat const kDTCollectionViewCellHeight = 60.0;

static NSString * const kDTProjectDetailCellReuseId = @"_dt.reuse.projectDetailCell";
static NSString * const kDTProjectDetailSectionReuseId = @"_dt.reuse.projectDetailSection";

@interface DTProjectDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation DTProjectDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  CGFloat x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  
  x = 0.0, y = 0.0, w = self.view.bounds.size.width, h = self.view.bounds.size.height;
  self.collectionView.frame = CGRectMake(x, y, w, h);
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
  
  cell.contentView.backgroundColor = [UIColor cyanColor];
  cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
  cell.taskTitleLabel.text = @"This is a title text label.";
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  
  DTProjectDetailSectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDTProjectDetailSectionReuseId forIndexPath:indexPath];
  
  header.sectionTitleLabel.text = @"In Progress";
  return header;
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 3;
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

@end
