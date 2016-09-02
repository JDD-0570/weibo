//
//  JDDTabBarController.m
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDTabBarController.h"
#import "JDDHomeViewController.h"
#import "JDDDiscoverViewController.h"
#import "JDDMessageViewController.h"
#import "JDDProfileViewController.h"
#import "JDDNavigationController.h"
#import "JDDTabBar.h"
#import "JDDComposeViewController.h"
@interface JDDTabBarController ()<JDDTabBarDelegate>

@end

@implementation JDDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加所有的子控制器
    [self addAllChildVcs];
    
    //创建自定义tabbar
    [self addCustomTabBar];
}
/*
    创建自定义tabbar
 */
- (void)addCustomTabBar
{
    //创建自定义tabbar
    JDDTabBar * customTabBar = [[JDDTabBar alloc]init];
    customTabBar.delegate = self;
    //更换系统自带的tabbar
    [self setValue:customTabBar forKey:@"tabBar"];
}
/*
    添加所有的子控制器
 */
- (void)addAllChildVcs
{
    JDDHomeViewController *home = [[JDDHomeViewController alloc]init];
    [self addChildViewController:home title:@"首页" imageNamed:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    JDDMessageViewController *message = [[JDDMessageViewController alloc]init];
    [self addChildViewController:message title:@"消息" imageNamed:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    JDDDiscoverViewController *discover = [[JDDDiscoverViewController alloc]init];
    [self addChildViewController:discover title:@"发现" imageNamed:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    JDDProfileViewController *profile = [[JDDProfileViewController alloc]init];
    [self addChildViewController:profile title:@"我" imageNamed:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    

}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    //强制重新布局子控件（内不会调用layoutSubviews）
//    [self.tabBar setNeedsLayout];
//}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageNamed:(NSString *)imageNamed selectedImage:(NSString *)selectedImageName
{
    //设置标题
    childController.title = title;
    //设置图标
    childController.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    //设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
//    childController.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    //设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (ios7) {
        //声明这张图片用原图（别渲染）
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childController.tabBarItem.selectedImage = selectedImage;
    
    //添加为tabbar控制器的子控制器
    JDDNavigationController *nav = [[JDDNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
    
}
#pragma make - JDDTabBarDelegate
- (void)tabBarDidClickedPlusButton:(JDDTabBar *)tabBar
{
    //弹出发微博控制器
    JDDComposeViewController *compose = [[JDDComposeViewController alloc]init];
    JDDNavigationController *nav = [[JDDNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
