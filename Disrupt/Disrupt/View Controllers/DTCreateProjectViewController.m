//
//  DTCreateProjectViewController.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTCreateProjectViewController.h"
#import "DTTaskTableViewCell.h"
#import "DTTeamCollectionViewCell.h"
#import "DTProjectManager.h"
#import "DTTeamManager.h"
#import "DTTask.h"

static NSString * kDTTaskReuseIdentifier = @"dt.reuseId.task";
static NSString * kDTTeamReuseIdentifier = @"dt.reuseId.team";
static CGFloat const kDTTaskCellHeight = 80.0;

@interface DTCreateProjectViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *taskTableView;
@property (nonatomic, strong) UICollectionView *teamCollectionView;

@property (nonatomic, strong) DTProjectManager *projectManager;
@property (nonatomic, strong) DTTeamManager *teamManager;

@property (nonatomic) NSInteger taskCount;

@end

@implementation DTCreateProjectViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.taskCount = 0;
  
  [self.view addSubview:self.taskTableView];
  [self.view addSubview:self.teamCollectionView];
//  [self layoutSubviews];
  [self.view layoutIfNeeded];
  [self.view setNeedsDisplay];
  [self.view setNeedsLayout];
}

- (void)layoutSubviews {
  
}

#pragma mark - Layout
- (void)viewWillLayoutSubviews {
  CGFloat fullWidth = CGRectGetWidth(self.view.bounds),
  horizontalMargin = 20.0,
  verticalMargin = 20.0;
  
  CGFloat x = horizontalMargin, y = 100.0, w = fullWidth - 2 * horizontalMargin;
  
  CGFloat fullHeight = kDTTaskCellHeight * (1 + self.taskCount);
  CGFloat h = fullHeight;
  
  self.taskTableView.frame = CGRectMake(x, y, w, h);
  
  x += horizontalMargin, y += verticalMargin, w -= 2 * horizontalMargin, h = w;
  self.teamCollectionView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy initialization
- (UITableView *)taskTableView {
  if (_taskTableView == nil) {
    _taskTableView = [UITableView new];
    _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _taskTableView.rowHeight = kDTTaskCellHeight;
    _taskTableView.dataSource = self;
    _taskTableView.delegate = self;
    [_taskTableView registerClass:[DTTaskTableViewCell class] forCellReuseIdentifier:kDTTaskReuseIdentifier];
  }
  return _taskTableView;
}

- (UICollectionView *)teamCollectionView {
  if (_teamCollectionView == nil) {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _teamCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _teamCollectionView.backgroundColor = [UIColor lightGrayColor];
    _teamCollectionView.dataSource = self;
    _teamCollectionView.delegate = self;
    [_teamCollectionView registerClass:[DTTeamCollectionViewCell class] forCellWithReuseIdentifier:kDTTeamReuseIdentifier];
    _teamCollectionView.hidden = YES;
  }
  return _teamCollectionView;
}

- (DTProjectManager *)projectManager {
  if (_projectManager == nil) {
    _projectManager = [DTProjectManager sharedManager];
  }
  return _projectManager;
}

- (DTTeamManager *)teamManager {
  if (_teamManager == nil) {
    _teamManager = [DTTeamManager sharedManager];
    _teamManager.teamMembers = [[NSMutableArray alloc] initWithArray:@[@"Al", @"Danny", @"Kevin", @"Rich"]];
  }
  return _teamManager;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.taskCount + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  DTTaskTableViewCell *cell = (DTTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kDTTaskReuseIdentifier];
  NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
  NSInteger taskNumber = rowCount - indexPath.row - 1;
  cell.taskTextField.delegate = self;
  if (indexPath.row == 0) {
    cell.taskTextField.text = @"";
  } else {
    cell.taskTextField.userInteractionEnabled = NO;
    if (taskNumber < [self.projectManager.tasks count]) {
      DTTask *task = self.projectManager.tasks[taskNumber];
      cell.taskTextField.text = task.taskDescription;
      cell.teamMemberLabel.text = task.assignedUser.userName;
    }
  }
  return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  self.teamCollectionView.hidden = NO;
  if (textField.text.length > 0) {
    
    DTTask *task = [DTTask new];
    task.taskDescription = textField.text;
    [self.projectManager.tasks addObject:task];
    
    self.taskCount ++;
//    [self layoutSubviews];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
    [self.taskTableView reloadData];
  }
  return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
  return [self.teamManager.teamMembers count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  DTTeamCollectionViewCell *cell = (DTTeamCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDTTeamReuseIdentifier forIndexPath:indexPath];
  cell.nameLabel.text = self.teamManager.teamMembers[indexPath.row];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  DTTask *task = [self.projectManager.tasks lastObject];
  DTTeamCollectionViewCell *cell = (DTTeamCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  task.assignedUser.userName = cell.nameLabel.text;
  self.teamCollectionView.hidden = YES;
  [self.taskTableView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat size = CGRectGetWidth(self.teamCollectionView.frame) / sqrt([self.teamManager.teamMembers count]);
  return CGSizeMake(size - 20.0, size - 20.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsZero;
}

@end
