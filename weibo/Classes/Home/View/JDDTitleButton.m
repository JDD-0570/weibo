//
//  JDDTitleButton.m
//  weibo
//
//  Created by JDD on 16/1/8.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDTitleButton.h"

@implementation JDDTitleButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //字体
        self.titleLabel.font = JDDNavigationTitleFont;
        //高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);

}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}
@end
