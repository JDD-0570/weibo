//
//  JDDComposePhotosView.m
//  weibo
//
//  Created by JDD on 16/3/12.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDComposePhotosView.h"

@implementation JDDComposePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;//保证是原来图片的大小
    imageView.clipsToBounds = YES;//适应固定好的图片范围
    imageView.image = image;
    [self addSubview:imageView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    //一行最大的列数
    int maxColsperRow = 4;
    
    //每个图片之间的距离
    CGFloat margin = 10;
    
    //每个图片的宽度
    CGFloat imageViewW = (self.width - (maxColsperRow + 1) * margin) / maxColsperRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++) {
        //行号
        int row = i / maxColsperRow;
        //列号
        int col = i % maxColsperRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin) + margin;
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}
@end
