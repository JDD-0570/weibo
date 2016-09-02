//
//  JDDAccountTool.h
//  weibo
//
//  Created by JDD on 16/3/7.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDDAccount;
@interface JDDAccountTool : NSObject
/**
 *  存储帐号
 */
+ (void)save:(JDDAccount *)account;

/**
 *  读取帐号
 */
+ (JDDAccount *)account;
@end
