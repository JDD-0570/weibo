//
//  JDDMessageViewController.m
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDMessageViewController.h"

@interface JDDMessageViewController ()

@end

@implementation JDDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"写私信" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    //设置按钮文字的尺寸为按纽自己的尺寸
//    button.size = [button.currentTitle sizeWithFont:button.titleLabel.font];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"消息测试数据-------%i",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor blueColor];
    newVc.title = @"新控制器";
    [self.navigationController pushViewController:newVc animated:YES];
    
}

@end
