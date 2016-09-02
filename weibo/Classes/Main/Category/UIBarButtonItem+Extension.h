//
//  UIBarButtonItem+Extension.h
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
