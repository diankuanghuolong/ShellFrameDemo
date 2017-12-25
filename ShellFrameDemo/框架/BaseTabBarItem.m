//
//  TabBarItem.m
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import "BaseTabBarItem.h"
#define IMAGEVIEW_WIDTH 26.f //tabbarIV宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation BaseTabBarItem

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //tabbar iv
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3 - IMAGEVIEW_WIDTH)/2,5, IMAGEVIEW_WIDTH, IMAGEVIEW_WIDTH)];
        _imageView.userInteractionEnabled = YES;
        
        //tabbar titleLabel
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH/3, 15)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        //        _titleLabel.textColor = BLACKCOLOR2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = YES;
        
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        
        //消息处理 tabbar messageL 样式自定义
        _messageL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)-10, 4, 25, 14)];
        //        _messageInstV.backgroundColor = REDCOLOR;
        _messageL.text = @""/*@"消息"*/;
        _messageL.textAlignment = NSTextAlignmentCenter;
        _messageL.font = [UIFont systemFontOfSize:10];
        _messageL.textColor = [UIColor whiteColor];
        _messageL.layer.cornerRadius = 7;
        _messageL.layer.masksToBounds = YES;
        [self addSubview:_messageL];
        
        _messageL.hidden = YES;
    }
    return self;
}

-(void)addTapGestureRecognizer:(id)sender action:(SEL)sel
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:sender action:sel];
    [self addGestureRecognizer:tap];
}
@end
