//
//  JDDNavigationController.m
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDNavigationController.h"

@interface JDDNavigationController ()

@end

@implementation JDDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (void)initialize
{
    //设置UINavigationBarThem的主题
    [self setupNavigationBarThem];
    //设置UIBarButtonItemThem的主题
    [self setupBarButtonItemTheme];
}
/**设置UINavigationBarThem的主题**/
+ (void)setupNavigationBarThem
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    //设置导航栏背景
    if (!ios7) {
        [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    //设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    //UIOffsetZero是结构体，只有包装成NSValue对象，才能放进字典/数组中
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}
/**
*设置UIBarButtonItem的主题
**/
+ (void)setupBarButtonItemTheme
{
    //通过appearance对象能够修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    //设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置高亮状态的文字属性
    NSMutableDictionary *hightTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    hightTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [appearance setTitleTextAttributes:hightTextAttrs forState:UIControlStateHighlighted];
    
    //设置不可用状态（disable）的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    /**设置背景**/
    //技巧：为了让某个按钮的背景消失，可以设置一张完全透明的背景图片
    [appearance setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}
/*
* 能拦截所有Push进来的子控制器
*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {//如果现在push的不是栈顶控制器（最先push进来的那个控制器）
        //设置导航栏按钮
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
