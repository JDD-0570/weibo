//
//  JDDDiscoverViewController.m
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDDiscoverViewController.h"

@interface JDDDiscoverViewController ()

@end

@implementation JDDDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JDDSearchBar *searchaBar = [JDDSearchBar searchBar];
    searchaBar.width = 300;
    searchaBar.height = 30;
    
    self.navigationItem.titleView = searchaBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
