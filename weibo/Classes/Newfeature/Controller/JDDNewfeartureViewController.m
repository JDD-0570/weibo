//
//  JDDNewfeartureViewController.m
//  weibo
//
//  Created by JDD on 16/1/13.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDNewfeartureViewController.h"
#import "JDDTabBarController.h"
#define JDDNewfeatureImageCount 4
@interface JDDNewfeartureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation JDDNewfeartureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加UIScrollView
    [self setupScrollView];
    
    //添加pageControl
    [self setupPageControl];
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
/*
    添加UIScrollVoiew
 */
- (void)setupScrollView
{
        //添加ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i < JDDNewfeatureImageCount; i++) {
        //创建UIImageView
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d.imageset",i + 1];
        if (FourInch) {//4inch  需要手动去加载4inch对应的-568h图片
            name = [name stringByAppendingString:@"-568h"];
        }
        imageView.image = [UIImage imageWithName:name];
        //NSLog(@"%@",name);
        
        [scrollView addSubview:imageView];
        
        //设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        //给最后一个imageView添加按钮
        if (i == JDDNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //设置其他属性
    scrollView.contentSize = CGSizeMake(JDDNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = JDDColor(246, 246, 246);
}
/*
    添加pageControl
 */
- (void)setupPageControl
{
    //添加
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = JDDNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.9;
    [self.view addSubview:pageControl];
    
    //设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = JDDColor(253, 98, 42);//当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = JDDColor(189, 189, 189);//非当前页的小圆点颜色
    self.pageControl = pageControl;
}
#pragma -make - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    //设置页码
    self.pageControl.currentPage = intPage;
}
/*
    设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    //添加开始按钮
    [self setupStartButton:imageView];
    //添加分享按钮
    [self setupShareButton:imageView];
}
/*
    添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    //添加分享按钮
    UIButton *shareButton = [[UIButton alloc]init];
    [imageView addSubview:shareButton];
    
    //设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    //监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    
    //设置间距
    //titleEdgeInsets : 切掉按钮内部UILabel的内容
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
/*
    分享
 */
- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
}
/*
    添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    //添加开始按钮
    UIButton *startButton = [[UIButton alloc]init];
    [imageView addSubview:startButton];
    
    //设置背景图片
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    //设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    //设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}
/*
    开始微博
 */
- (void)start
{
    NSLog(@"开始");
    JDDTabBarController *vc = [[JDDTabBarController alloc]init];
    
    //切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}
@end
