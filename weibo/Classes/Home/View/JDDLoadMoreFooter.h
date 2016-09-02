//
//  JDDLoadMoreFooter.h
//  weibo
//
//  Created by JDD on 16/3/10.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDDLoadMoreFooter : UIView
+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (nonatomic, assign, getter= isRefreshing)BOOL refreshing;
@end
