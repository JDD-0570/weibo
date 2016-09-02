//
//  JDDTextView.m
//  weibo
//
//  Created by JDD on 16/3/11.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDTextView.h"

@interface JDDTextView () <UITextViewDelegate>
@property (nonatomic, weak)UILabel *placehoderLabel;
@end

@implementation JDDTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //添加一个显示文字的label（显示占位文字的label）
        UILabel *placehodeLabel = [[UILabel alloc]init];
        placehodeLabel.numberOfLines = 0;
        placehodeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehodeLabel];
        self.placehoderLabel = placehodeLabel;
        
        //设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        //设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
#warning 不要设置自己的代理为自己本身
        // 监听内部文字改变
        //        self.delegate = self;
        
        /**
         监听控件的事件：
         1.delegate
         2.- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
         3.通知
         */
        
        // 当用户通过键盘修改了self的文字，self就会自动发出一个UITextViewTextDidChangeNotification通知
        // 一旦发出上面的通知，就会调用self的textDidChange方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 监听文字改变
- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
}

#pragma mark - 公共方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}
- (void)setPlacehoder:(NSString *)placehoder
{
#warning 如果是copy策略，setter最好这么写
    _placehoder = [placehoder copy];
    
    //设置文字
    self.placehoderLabel.text = placehoder;
    
    //重新计算子控件的frame
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    //设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    //重新计算子控件的frame
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placehoderLabel.y = 8;
    self.placehoderLabel.x = 5;
    self.placehoderLabel.width = self.width - 2 * self.placehoderLabel.x;
    //根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize];
    self.placehoderLabel.height = placehoderSize.height;
}
@end
