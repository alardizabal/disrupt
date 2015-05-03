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
#import <AFNetworking/AFNetworking.h>

static NSString * kDTTaskReuseIdentifier = @"dt.reuseId.task";
static NSString * kDTTeamReuseIdentifier = @"dt.reuseId.team";
static CGFloat const kDTTaskCellHeight = 50.0;

@interface DTCreateProjectViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

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
@property (nonatomic, strong) UIImageView *dimView;

@property (nonatomic, strong) DTProjectManager *projectManager;
@property (nonatomic, strong) DTTeamManager *teamManager;

@end

@implementation DTCreateProjectViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"NEW PROJECT";
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  [self.view addSubview:self.headerView];
  [self.view addSubview:self.projectNameTextField];
  [self.view addSubview:self.taskTableView];
  [self.headerView addSubview:self.taskNumberLabel];
  [self.headerView addSubview:self.taskDescriptionLabel];
  [self.headerView addSubview:self.taskMemberLabel];
  [self.view addSubview:self.dimView];
  [self.view addSubview:self.teamCollectionView];
  [self.view setNeedsDisplay];
  [self.view setNeedsLayout];
  [self.view layoutIfNeeded];
  
  [self.projectManager.tasks removeAllObjects];
  [self.taskTableView reloadData];
  [self.projectNameTextField becomeFirstResponder];
  
  [self setupNavBar];
}

#pragma mark - Layout
- (void)viewWillLayoutSubviews {
  CGFloat fullWidth = CGRectGetWidth(self.view.bounds),
  fullHeight = CGRectGetHeight(self.view.bounds),
  horizontalMargin = 20.0,
  verticalMargin = 20.0;
  
  CGFloat x = 0.0, y = 0.0, w = fullWidth, h = fullHeight;
  self.dimView.frame = CGRectMake(x, y, w, h);
  
  x = 0.0, y = verticalMargin, w = fullWidth, h = 60.0;
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

- (void)setupNavBar {
  UIImage *leftButtonImage = [[UIImage imageNamed:@"icon-arrow-left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *leftButtonImagePressed = [UIImage imageNamed:@"icon-arrow-left"];
  UIButton *leftButton = [UIButton new];
  [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
  [leftButton setImage:leftButtonImagePressed forState:UIControlStateHighlighted];
  leftButton.frame = CGRectMake(0.0, 0.0, 10.0, 20.0);
  leftButton.tintColor = [UIColor whiteColor];
  [leftButton addTarget:self action:@selector(tappedLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
  
  UIImage *rightButtonImage = [[UIImage imageNamed:@"icon-checkbox-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *rightButtonImagePressed = [UIImage imageNamed:@"icon-checkbox-selected"];
  UIButton *rightButton = [UIButton new];
  rightButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 7.0, 0.0);
  [rightButton setImage:rightButtonImage forState:UIControlStateNormal];
  [rightButton setImage:rightButtonImagePressed forState:UIControlStateHighlighted];
  rightButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
  rightButton.tintColor = [UIColor whiteColor];
  [rightButton addTarget:self action:@selector(tappedSaveButton:) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - Lazy initialization
- (UITextField *)projectNameTextField {
  if (_projectNameTextField == nil) {
    _projectNameTextField = [UITextField new];
    _projectNameTextField.delegate = self;
    _projectNameTextField.placeholder = @"PROJECT NAME";
    _projectNameTextField.textAlignment = NSTextAlignmentCenter;
    _projectNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:40.0];
    _projectNameTextField.textColor = [UIColor darkGrayColor];
    _projectNameTextField.tintColor = [UIColor dtBlueColor];
    _projectNameTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
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
    _taskNumberLabel.textColor = [UIColor dtBlueColor];
    _taskNumberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskNumberLabel;
}

- (UILabel *)taskDescriptionLabel {
  if (_taskDescriptionLabel == nil) {
    _taskDescriptionLabel = [UILabel new];
    _taskDescriptionLabel.text = @"Task";
    _taskDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskDescriptionLabel.textColor = [UIColor dtBlueColor];
    _taskDescriptionLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskDescriptionLabel;
}

- (UILabel *)taskMemberLabel {
  if (_taskMemberLabel == nil) {
    _taskMemberLabel = [UILabel new];
    _taskMemberLabel.text = @"Member";
    _taskMemberLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    _taskMemberLabel.textColor = [UIColor dtBlueColor];
    _taskMemberLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _taskMemberLabel;
}

- (UITableView *)taskTableView {
  if (_taskTableView == nil) {
    _taskTableView = [UITableView new];
    _taskTableView.separatorColor = [UIColor whiteColor];
    _taskTableView.backgroundColor = [UIColor dtBlueColor];
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
    _teamCollectionView.backgroundColor = [UIColor whiteColor];
    _teamCollectionView.dataSource = self;
    _teamCollectionView.delegate = self;
    [_teamCollectionView registerClass:[DTTeamCollectionViewCell class] forCellWithReuseIdentifier:kDTTeamReuseIdentifier];
    _teamCollectionView.hidden = YES;
  }
  return _teamCollectionView;
}

- (UIImageView *)dimView {
  if (_dimView == nil) {
    _dimView = [UIImageView new];
    _dimView.userInteractionEnabled = YES;
    [_dimView addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOverlay:)]];
    _dimView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _dimView.hidden = YES;
  }
  return _dimView;
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
    
    DTUserModel *al = [DTUserModel new];
    al.userName = @"Al";
    al.userId = @"DUVJT93474LOT2472";
    DTUserModel *rich = [DTUserModel new];
    rich.userName = @"Rich";
    rich.userId = @"DUDTI75445ECX6555";
    DTUserModel *kevin = [DTUserModel new];
    kevin.userName = @"Kevin";
    kevin.userId = @"DUHAL68180LFS6953";
    DTUserModel *danny = [DTUserModel new];
    danny.userName = @"Danny";
    danny.userId = @"DUVJT93474GUY2472";
    _teamManager.teamMembers = [[NSMutableArray alloc] initWithArray:@[al, rich, kevin, danny]];
    
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
  cell.taskDescriptionTextView.delegate = self;
  cell.taskNumberLabel.text = [NSString stringWithFormat:@"%ld", taskNumber + 1];
  if (indexPath.row == 0) {
    cell.taskDescriptionTextView.userInteractionEnabled = YES;
    cell.taskDescriptionTextView.text = @"";
    cell.taskMemberLabel.text = @"";
  } else {
    cell.taskDescriptionTextView.userInteractionEnabled = NO;
    if (taskNumber < [self.projectManager.tasks count]) {
      DTTask *task = self.projectManager.tasks[taskNumber];
      cell.taskDescriptionTextView.text = task.taskDescription;
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    [tableView setSeparatorInset:UIEdgeInsetsZero];
  }
  
  if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [tableView setLayoutMargins:UIEdgeInsetsZero];
  }
  
  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsZero];
  }
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
      self.dimView.hidden = NO;
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
  cell.user = self.teamManager.teamMembers[indexPath.row];
  cell.nameLabel.text = [cell.user.userName uppercaseString];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  DTTask *task = [self.projectManager.tasks lastObject];
  DTTeamCollectionViewCell *cell = (DTTeamCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  task.assignedUser = cell.user;
  
  self.teamCollectionView.hidden = YES;
  self.dimView.hidden = YES;
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
  return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 1.0;
}
  
#pragma mark - Network Tasks

- (void)postNewProject {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  
  NSString *URLString = @"http://api.localhost.local:3040/projects/create";
  NSMutableDictionary *payload = [NSMutableDictionary new];
  NSDictionary *project = @{@"title" : self.projectNameTextField.text};
  payload[@"project"] = project;
  NSMutableArray *taskParams = [NSMutableArray new];
  for (DTTask *task in self.projectManager.tasks) {
    NSMutableDictionary *taskDict = [NSMutableDictionary new];
    taskDict[@"user_id"] = task.assignedUser.userId;
    taskDict[@"description"] = task.taskDescription;
    taskDict[@"minutes"] = @60;
    taskDict[@"estimate"] = @300;
    taskDict[@"status"] = @"inactive";
    [taskParams addObject:taskDict];
  }
  payload[@"tasks"] = taskParams;
  
  [manager POST:URLString parameters:payload
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self.navigationController popViewControllerAnimated:YES];
  }
        failure:
   ^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error);
   }];
}

#pragma mark - Actions
- (void)tappedLeftBarButton:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tappedSaveButton:(id)sender {
  [self postNewProject];
}

- (void)tappedOverlay:(id)sender {
  self.dimView.hidden = YES;
  self.teamCollectionView.hidden = YES;
}

@end
