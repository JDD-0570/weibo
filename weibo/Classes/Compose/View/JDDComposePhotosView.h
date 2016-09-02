//
//  JDDComposePhotosView.h
//  weibo
//
//  Created by JDD on 16/3/12.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDDComposePhotosView : UIView

/**
    添加一张图片到相册内部
    
    @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;
@end
