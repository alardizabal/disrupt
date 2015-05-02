//
//  DTCreateProjectViewController.m
//  Disrupt
//
//  Created by Rich McAteer on 5/2/15.
//  Copyright (c) 2015 Posse. All rights reserved.
//

#import "DTCreateProjectViewController.h"
#import "DTTaskTableViewCell.h"

static NSString * kDTTaskReuseIdentifier = @"dt.reuseId.task";

@interface DTCreateProjectViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *taskTableView;

@end

@implementation DTCreateProjectViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addSubview:self.taskTableView];
  [self layoutSubviews];
}

#pragma mark - Layout
- (void)layoutSubviews {
  CGFloat fullWidth = CGRectGetWidth(self.view.bounds);
  
  CGFloat x = 0.0, y = 100.0, w = fullWidth, h = 60.0;
  self.taskTableView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Lazy initialization
- (UITableView *)taskTableView {
  if (_taskTableView) {
    _taskTableView = [UITableView new];
    _taskTableView.dataSource = self;
    _taskTableView.delegate = self;
    [_taskTableView registerClass:[DTTaskTableViewCell class] forCellReuseIdentifier:kDTTaskReuseIdentifier];
  }
  return _taskTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  DTTaskTableViewCell *cell = (DTTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kDTTaskReuseIdentifier];
  return cell;
}

#pragma mark - UITableViewDelegate


@end
