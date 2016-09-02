//
//  JDDAccount.h
//  weibo
//
//  Created by JDD on 16/3/7.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDAccount : NSObject<NSCoding>
/** string 	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/** string 	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** string 	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
