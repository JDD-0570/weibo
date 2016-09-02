//
//  JDDTabBar.h
//  weibo
//
//  Created by JDD on 16/1/12.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDDTabBar;

@protocol JDDTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(JDDTabBar *)tabBar;
@end
@interface JDDTabBar : UITabBar
@property (nonatomic,weak) id<JDDTabBarDelegate>delegate;
@end
