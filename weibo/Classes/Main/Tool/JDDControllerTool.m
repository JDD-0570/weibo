//
//  JDDControllerTool.m
//  weibo
//
//  Created by JDD on 16/3/7.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDControllerTool.h"
#import "JDDTabBarController.h"
#import "JDDNewfeartureViewController.h"
@implementation JDDControllerTool
+ (void)chooseRootViewController
{
    //如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    //从沙河中取出上次存储的软件版本号（取出用户上次的使用记录）
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    //获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {//当前版本号==上次使用的版本显示JDDTabBarController
        window.rootViewController = [[JDDTabBarController alloc]init];
    }else{//当前版本号==上次使用的版本显示新特性版本
        window.rootViewController = [[JDDNewfeartureViewController alloc]init];
        
        //存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }

}
@end
