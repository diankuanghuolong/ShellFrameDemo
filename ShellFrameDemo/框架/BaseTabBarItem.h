//
//  TabBarItem.h
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
自定义tabbarItem
 
*/

@interface BaseTabBarItem : UIView
#pragma mark  ===== property  =====
@property(nonatomic,strong)UILabel * messageL;      //----------消息处理 tabbar messageL 样式自定义
@property(nonatomic,strong)UIImageView * imageView;//-----------tabbar iv
@property(nonatomic,strong)UILabel * titleLabel;   //-----------tabbar titleLabel

#pragma mark  ===== tap  =====
-(void)addTapGestureRecognizer:(id)sender action:(SEL)sel;//----点击手势
@end
