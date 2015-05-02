//
//  DTDashboardViewController.m
//  Disrupt
//
//  Created by Kevin Gray on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTDashboardViewController.h"
#import "DTDashboardCollectionViewCell.h"
#import "DTProjectModel.h"
#import "DTCreateProjectViewController.h"
#import "DTProjectDetailViewController.h"

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
  self.navigationItem.title = @"Disrupt";
  [self addLeftNavigationButton];
  [self addRightNavigationButton];
  
  [self.view addSubview:self.projectCollectionView];
  [self requestProjects];
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

- (void) addLeftNavigationButton {
  UIImage *settingsImage = [UIImage imageNamed:@"icon_minus"];
  UIImage *settingsImagePressed = [UIImage imageNamed:@"icon_minus"];
  UIButton *settingsButton = [UIButton new];
  [settingsButton setImage:settingsImage forState:UIControlStateNormal];
  [settingsButton setImage:settingsImagePressed forState:UIControlStateHighlighted];
  settingsButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
  [settingsButton addTarget:self action:@selector(tappedLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
}

- (void) addRightNavigationButton {
  UIImage *settingsImage = [UIImage imageNamed:@"icon_plus"];
  UIImage *settingsImagePressed = [UIImage imageNamed:@"icon_plus"];
  UIButton *settingsButton = [UIButton new];
  [settingsButton setImage:settingsImage forState:UIControlStateNormal];
  [settingsButton setImage:settingsImagePressed forState:UIControlStateHighlighted];
  settingsButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
  [settingsButton addTarget:self action:@selector(tappedRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
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

#pragma mark - Testing Functions 
- (void) createTestProjects {
  DTProjectModel *tasteTracker = [DTProjectModel new];
  tasteTracker.projectName = @"TasteTracker";
  tasteTracker.percentComplete = @69;
  DTProjectModel *babbygooroo = [DTProjectModel new];
  babbygooroo.projectName = @"Baby GooRoo";
  babbygooroo.percentComplete = @90;
  DTProjectModel *shoptiques = [DTProjectModel new];
  shoptiques.projectName = @"Shoptiques";
  shoptiques.percentComplete = @100;
  DTProjectModel *briq = [DTProjectModel new];
  briq.projectName = @"BRIQ";
  briq.percentComplete = @100;
  DTProjectModel *hypeWriter = [DTProjectModel new];
  hypeWriter.projectName = @"HypeWriter";
  hypeWriter.percentComplete = @76;
  self.projects = [[NSMutableArray alloc] initWithArray:@[tasteTracker, babbygooroo, shoptiques, hypeWriter, briq]];
}

#pragma mark - Network Calls
- (void) requestProjects {
  NSString *URLStr = @"http://api.localhost.local:3040/dashboard";
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]];
  NSData *data = [NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil error:nil];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  NSArray *projects = json[@"response"][@"data"][@"projects"];
  for (NSDictionary *project in projects) {
    DTProjectModel *projModel = [[DTProjectModel alloc] initWithJSONData:project];
    [self.projects addObject:projModel];
  }
}

#pragma mark - UICollectionViewDelegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.projects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  DTDashboardCollectionViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kDTDashboardCellReuseId
                                            forIndexPath:indexPath];
  NSString *projNameForCell = ((DTProjectModel*)self.projects[indexPath.row]).projectName;
  NSNumber *projCompletePercent = ((DTProjectModel*)self.projects[indexPath.row]).percentComplete;
  [cell setProjectName:projNameForCell];
  [cell setProjectPercentage:projCompletePercent];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(self.view.frame.size.width, 80.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSString *projNameForCell = ((DTProjectModel*)self.projects[indexPath.row]).projectName;
  
  DTProjectDetailViewController *vc = [DTProjectDetailViewController new];
  [self.navigationController pushViewController:vc animated:YES];
  NSLog(@"%@",projNameForCell);
}

#pragma mark - Navigation Actions
- (void) tappedRightBarButton:(id) sender {
  DTCreateProjectViewController *vc = [DTCreateProjectViewController new];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void) tappedLeftBarButton:(id) sender {
  NSLog(@"Tapped left bar button");
}

@end
