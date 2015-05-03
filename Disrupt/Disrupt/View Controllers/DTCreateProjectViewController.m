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

@interface DTCreateProjectViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITextField *projectNameTextField;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *taskNumberLabel;
@property (nonatomic, strong) UILabel *taskDescriptionLabel;
@property (nonatomic, strong) UILabel *taskMemberLabel;
@property (nonatomic, strong) UITableView *taskTableView;
@property (nonatomic, strong) UICollectionView *teamCollectionView;
@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UILabel *editNumberLabel;
@property (nonatomic, strong) UITextView *editDescriptionTextView;
@property (nonatomic, strong) UILabel *editMemberLabel;

@property (nonatomic, strong) DTProjectManager *projectManager;
@property (nonatomic, strong) DTTeamManager *teamManager;

@end

@implementation DTCreateProjectViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor darkGrayColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  [self.view addSubview:self.projectNameTextField];
  [self.view addSubview:self.taskTableView];
  [self.view addSubview:self.teamCollectionView];
  [self.view addSubview:self.headerView];
  [self.headerView addSubview:self.taskNumberLabel];
  [self.headerView addSubview:self.taskDescriptionLabel];
  [self.headerView addSubview:self.taskMemberLabel];
  [self.view setNeedsDisplay];
  [self.view setNeedsLayout];
  [self.view layoutIfNeeded];
}

#pragma mark - Layout
- (void)viewWillLayoutSubviews {
  CGFloat fullWidth = CGRectGetWidth(self.view.bounds),
  fullHeight = CGRectGetHeight(self.view.bounds),
  horizontalMargin = 20.0,
  verticalMargin = 20.0;
  
  CGFloat x = 0.0, y = verticalMargin, w = fullWidth, h = 60.0;
  self.projectNameTextField.frame = CGRectMake(x, y, w, h);
  
  y = CGRectGetMaxY(self.projectNameTextField.frame) + verticalMargin, h = 30.0;
  self.headerView.frame = CGRectMake(x, y, w, h);
  
  y = 0.0, w = 50.0;
  self.taskNumberLabel.frame = CGRectMake(x, y, w, h);
  
  x += w, w = fullWidth - 150.0;
  self.taskDescriptionLabel.frame = CGRectMake(x, y, w, h);
  
  x += w, w = 100.0;
  self.taskMemberLabel.frame = CGRectMake(x, y, w, h);
  
  x = 0.0, y += CGRectGetMaxY(self.headerView.frame), w = fullWidth;
  CGFloat taskListHeight = kDTTaskCellHeight * (1 + [self.projectManager.tasks count]);
  CGFloat maxHeight = fullHeight - y;
  h = MIN(taskListHeight, maxHeight);
  self.taskTableView.frame = CGRectMake(x, y, w, h);
  
  x += horizontalMargin, y += verticalMargin, w -= 2 * horizontalMargin, h = kDTTaskCellHeight * [self.teamManager.teamMembers count];
  self.teamCollectionView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy initialization
- (UITextField *)projectNameTextField {
  if (_projectNameTextField == nil) {
    _projectNameTextField = [UITextField new];
    _projectNameTextField.delegate = self;
    _projectNameTextField.placeholder = @"Project name";
    _projectNameTextField.textAlignment = NSTextAlignmentCenter;
    _projectNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:28.0];
    _projectNameTextField.textColor = [UIColor whiteColor];
  }
  return _projectNameTextField;
}

- (UIView *)headerView {
  if (_headerView == nil) {
    _headerView = [UIView new];
  }
  return _headerView;
}

- (UILabel *)taskNumberLabel {
  if (_taskNumberLabel == nil) {
    _taskNumberLabel = [UILabel new];
    _taskNumberLabel.text = @"#";
    _taskNumberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskNumberLabel.textColor = [UIColor whiteColor];
    _taskNumberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskNumberLabel;
}

- (UILabel *)taskDescriptionLabel {
  if (_taskDescriptionLabel == nil) {
    _taskDescriptionLabel = [UILabel new];
    _taskDescriptionLabel.text = @"Task";
    _taskDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskDescriptionLabel.textColor = [UIColor whiteColor];
    _taskDescriptionLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskDescriptionLabel;
}

- (UILabel *)taskMemberLabel {
  if (_taskMemberLabel == nil) {
    _taskMemberLabel = [UILabel new];
    _taskMemberLabel.text = @"Member";
    _taskMemberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskMemberLabel.textColor = [UIColor whiteColor];
    _taskMemberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskMemberLabel;
}

- (UITableView *)taskTableView {
  if (_taskTableView == nil) {
    _taskTableView = [UITableView new];
    _taskTableView.separatorColor = [UIColor whiteColor];
    _taskTableView.backgroundColor = [UIColor colorWithRed:0/255.0f green:200/255.0f blue:180/255.0f alpha:1.0];
    _taskTableView.dataSource = self;
    _taskTableView.delegate = self;
    _taskTableView.allowsMultipleSelectionDuringEditing = NO;
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
    _teamManager.teamMembers = [[NSMutableArray alloc] initWithArray:@[@"Al", @"Danny", @"Kevin", @"Rich"]];
  }
  return _teamManager;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.projectManager.tasks count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  DTTaskTableViewCell *cell = (DTTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kDTTaskReuseIdentifier];
  NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
  NSInteger taskNumber = rowCount - indexPath.row - 1;
  cell.taskDesciptionTextView.delegate = self;
  cell.taskNumberLabel.text = [NSString stringWithFormat:@"%li", taskNumber + 1];
  if (indexPath.row == 0) {
    cell.taskDesciptionTextView.userInteractionEnabled = YES;
    cell.taskDesciptionTextView.text = @"";
    cell.taskMemberLabel.text = @"";
  } else {
    cell.taskDesciptionTextView.userInteractionEnabled = NO;
    if (taskNumber < [self.projectManager.tasks count]) {
      DTTask *task = self.projectManager.tasks[taskNumber];
      cell.taskDesciptionTextView.text = task.taskDescription;
      cell.taskMemberLabel.text = task.assignedUser.userName;
    }
  }
  return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kDTTaskCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  DTTaskTableViewCell *cell = (DTTaskTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//  CGFloat contentHeight = cell.taskDesciptionTextView.contentSize.height;
//  return MAX(kDTTaskCellHeight, contentHeight + 20.0);
  return kDTTaskCellHeight;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.row > 0) {
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    NSInteger taskNumber = rowCount - indexPath.row - 1;
    [self.projectManager.tasks removeObjectAtIndex:taskNumber];
    [self.taskTableView reloadData];
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
  }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  if([text isEqualToString:@"\n"]) {
    if (textView.text.length > 0) {
      self.teamCollectionView.hidden = NO;
      if (textView.text.length > 0) {
        DTTask *task = [DTTask new];
        task.taskDescription = textView.text;
        [self.projectManager.tasks addObject:task];
        
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
  task.assignedUser.userName = cell.nameLabel.text;
  self.teamCollectionView.hidden = YES;
  [self.taskTableView reloadData];
  [self.view layoutIfNeeded];
  [self.view setNeedsLayout];
  [self.view setNeedsDisplay];
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
