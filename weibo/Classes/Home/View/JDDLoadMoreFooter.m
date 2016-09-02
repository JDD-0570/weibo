//
//  JDDLoadMoreFooter.m
//  weibo
//
//  Created by JDD on 16/3/10.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDLoadMoreFooter.h"

@interface JDDLoadMoreFooter ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation JDDLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"JDDLoadMoreFooter" owner:nil options:nil]lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}
@end
