//
//  JDDComposeToolbar.h
//  weibo
//
//  Created by JDD on 16/3/11.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JDDComposeToolbarButtonTypeCamera, // 照相机
    JDDComposeToolbarButtonTypePicture, // 相册
    JDDComposeToolbarButtonTypeMention, // 提到@
    JDDComposeToolbarButtonTypeTrend, // 话题
    JDDComposeToolbarButtonTypeEmotion // 表情
} JDDComposeToolbarButtonType;

@class JDDComposeToolbar;

@protocol JDDComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(JDDComposeToolbar *)toolbar didClickedButton:(JDDComposeToolbarButtonType)buttonType;

@end

@interface JDDComposeToolbar : UIView
@property (nonatomic, weak)id<JDDComposeToolbarDelegate>delegate;

@end
