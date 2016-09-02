//
//  JDDUser.h
//  weibo
//
//  Created by JDD on 16/3/9.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDUser : NSObject
/** string 好友显示，名称 */
@property (nonatomic, copy)NSString *name;
/** string 用户头像地址(中国), 50*50像素 */
@property (nonatomic, copy)NSString *profile_image_url;

//+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
