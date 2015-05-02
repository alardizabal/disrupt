//
//  DTDashboardViewController.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTDashboardViewController.h"
#import "DTDashboardCollectionViewCell.h"

static NSString * const kDTDashboardCellReuseId = @"_dt.reuse.dashboardCell";

@interface DTDashboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *projectCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *projects;
@end

@implementation DTDashboardViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.projectCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  CGFloat x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  w = CGRectGetWidth(self.view.bounds), h = CGRectGetHeight(self.view.bounds);
  self.projectCollectionView.frame = CGRectMake(x, y, w, h);
}

#pragma mark

#pragma mark - Lazy Init

- (UICollectionView *)projectCollectionView {
  if (_projectCollectionView == nil) {
    _projectCollectionView =
    [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    _projectCollectionView.delegate = self;
    _projectCollectionView.dataSource = self;
    _projectCollectionView.backgroundColor = [UIColor whiteColor];
    [_projectCollectionView registerClass:[DTDashboardCollectionViewCell class]
        forCellWithReuseIdentifier:kDTDashboardCellReuseId];
    _projectCollectionView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
  }
  return _projectCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
  if (_flowLayout == nil) {
    _flowLayout = [UICollectionViewFlowLayout new];
  }
  return _flowLayout;
}

- (NSMutableArray *)projects {
  if (_projects == nil) {
    _projects = [NSMutableArray new];
  }
  return _projects;
}

#pragma mark - UICollectionViewDelegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 5;
  //return self.projects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  DTDashboardCollectionViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kDTDashboardCellReuseId
                                            forIndexPath:indexPath];
  return cell;
}
@end
