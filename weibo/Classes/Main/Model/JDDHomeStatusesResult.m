//
//  JDDHomeStatusesResult.m
//  weibo
//
//  Created by JDD on 16/3/17.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDHomeStatusesResult.h"
#import "JDDStatus.h"
@implementation JDDHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [JDDStatus class]};
}

@end
