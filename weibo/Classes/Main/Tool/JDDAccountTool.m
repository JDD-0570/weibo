//
//  JDDAccountTool.m
//  weibo
//
//  Created by JDD on 16/3/7.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//
#define JDDAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
#import "JDDAccountTool.h"
#import "JDDAccount.h"
@implementation JDDAccountTool
+ (void)save:(JDDAccount *)account
{
//    //存储账号信息
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *filepath = [doc stringByAppendingPathComponent:@"account.plist"];
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:JDDAccountFilepath];
}

+ (JDDAccount *)account
{
    // 读取帐号
    JDDAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:JDDAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */

@end
