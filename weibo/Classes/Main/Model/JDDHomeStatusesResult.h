//
//  JDDHomeStatusesResult.h
//  weibo
//
//  Created by JDD on 16/3/17.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDHomeStatusesResult : NSObject
/** 微博数组（装着HMStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;
@end
