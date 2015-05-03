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
static CGFloat const kDTTaskCellHeight = 50.0;

@interface DTCreateProjectViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITextField *projectNameTextField;
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
  
  self.view.backgroundColor = [UIColor darkGrayColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  self.taskCount = 0;
  
  [self.view addSubview:self.projectNameTextField];
  [self.view addSubview:self.taskTableView];
  [self.view addSubview:self.teamCollectionView];
}

#pragma mark - Layout
- (void)viewWillLayoutSubviews {
  CGFloat fullWidth = CGRectGetWidth(self.view.bounds),
  fullHeight = CGRectGetHeight(self.view.bounds),
  horizontalMargin = 20.0,
  verticalMargin = 20.0;
  
  CGFloat x = 0.0, y = verticalMargin, w = fullWidth, h = 60.0;
  self.projectNameTextField.frame = CGRectMake(x, y, w, h);
  
  y = CGRectGetMaxY(self.projectNameTextField.frame) + verticalMargin;
  CGFloat taskListHeight = kDTTaskCellHeight * (1 + self.taskCount);
  CGFloat maxHeight = fullHeight - y - CGRectGetHeight(self.navigationController.navigationBar.frame);
  h = MIN(taskListHeight, maxHeight);
  self.taskTableView.frame = CGRectMake(x, y, w, h);
  
  x += horizontalMargin, y += verticalMargin, w -= 2 * horizontalMargin, h = kDTTaskCellHeight * [self.teamManager.teamMembers count];
  self.teamCollectionView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy initialization
- (UITextField *)projectNameTextField {
  if (_projectNameTextField == nil) {
    _projectNameTextField = [UITextField new];
    _projectNameTextField.backgroundColor = [UIColor whiteColor];
    _projectNameTextField.placeholder = @"Enter project name";
  }
  return _projectNameTextField;
}

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
    _teamCollectionView.backgroundColor = [UIColor purpleColor];
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
    _teamManager.teamMembers = @[@"Al", @"Danny", @"Kevin", @"Rich"];
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
  cell.taskTextView.delegate = self;
  if (indexPath.row == 0) {
    cell.taskTextView.userInteractionEnabled = YES;
    cell.taskTextView.text = @"";
    cell.teamMemberLabel.text = @"";
  } else {
    cell.taskTextView.userInteractionEnabled = NO;
    if (taskNumber < [self.projectManager.tasks count]) {
      DTTask *task = self.projectManager.tasks[taskNumber];
      cell.taskTextView.text = task.taskDescription;
      cell.teamMemberLabel.text = task.teamMember;
    }
  }
  return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  if([text isEqualToString:@"\n"]) {
    if (textView.text.length > 0) {
      self.teamCollectionView.hidden = NO;
      if (textView.text.length > 0) {
        DTTask *task = [DTTask new];
        task.taskDescription = textView.text;
        [self.projectManager.tasks addObject:task];
        
        self.taskCount ++;
        [self.view setNeedsLayout];
        [self.taskTableView reloadData];
      }
    }
    return NO;
  }
  return YES;
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
  task.teamMember = cell.nameLabel.text;
  self.teamCollectionView.hidden = YES;
  [self.taskTableView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(CGRectGetWidth(collectionView.frame), kDTTaskCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0.0;
}

@end
