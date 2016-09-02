//
//  JDDStatus.m
//  weibo
//
//  Created by JDD on 16/3/9.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDStatus.h"
#import "JDDUser.h"
#import "JDDPhone.h"
@implementation JDDStatus
//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    JDDStatus *status = [[self alloc] init];
//    
//    status.text = dict[@"text"];
//    
//    status.user = [JDDUser userWithDict:dict[@"user"]];
//    
//    NSDictionary *retweetedDict = dict[@"retweeted_status"];
//    if (retweetedDict) {
//        status.retweeted_status = [JDDStatus statusWithDict:retweetedDict];
//    }
//    
//    return status;
//}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [JDDPhone class]};
}

@end
