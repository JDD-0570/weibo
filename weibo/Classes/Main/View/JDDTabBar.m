//
//  JDDTabBar.m
//  weibo
//
//  Created by JDD on 16/1/12.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDTabBar.h"
@interface JDDTabBar()
@property (nonatomic, weak) UIButton *plusButton;
@end


@implementation JDDTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮
        [self setupPlusButton];
    }
    return self;
}
/*
    添加加号按钮
 */
- (void)setupPlusButton
{
    UIButton *plusButton = [[UIButton alloc]init];
    
    //设置背景
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    //设置图标
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //添加
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}
- (void)plusButtonClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}
/*
 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置plusButton的frame
    [self setupPlusButtonFrame];
    
    //设置所有tabbarButton的frame
    [self setupAllTabBarButtonsframe];
}
/*
    设置plusButton的frame
 */
- (void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height *0.5);
}
- (void)setupAllTabBarButtonsframe
{
    int index = 0;
    
    //遍历所有的button
    for (UIView *tabBarBUtton in self.subviews) {
        //如果不是UITabBarButton，直接跳过
        if (![tabBarBUtton isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        
        //根据索引调整位置
        [self setupTabBarButtonFrame:tabBarBUtton atIndex:index];
        
        //遍历UITabBarButton中的所有子控件
//        [self setupTabBarButtonTextColor:tabBarBUtton atIndex:index];
        
        //索引增加
        index ++;
        
    }
}

/**
    设置某个按钮的文字颜色
    @param tabBarButton 需要设置的按钮
    @param index        按钮所在的索引
 */
//- (void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex: (int)index
//{
//    //选中按钮的索引
//    int selectedIndex = [self.items indexOfObject:self.selectedItem];
//    
//    for (UILabel *label in tabBarButton.subviews) {
//        //说明不是个label
//        if (![label isKindOfClass:[UILabel class]])continue;
//        
//        //设置字体
//        label.font = [UIFont systemFontOfSize:10];
//        if (selectedIndex == index) {//说明这个Button选中，设置label颜色为橙色
//            label.textColor = [UIColor orangeColor];
//        }else{//说明这个Button没有选中，设置label颜色为黑色
//            label.textColor = [UIColor blackColor];
//        }
//            
//    }
//}
/**
 *设置某个按钮的frame
 *
 *@param tabBarButton 需要设置的按钮
 *@param index         按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex: (int)index
{
    //计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    }else{
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}
@end
