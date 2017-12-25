//
//  TabBarVC.h
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarItem.h"
@interface BaseTabBarVC : UITabBarController
{
    NSArray * _images;
    NSArray * _selectImages;
    NSArray * _titles;
}
#pragma mark  ===== property  =====
@property(nonatomic,strong)UIView * bgView;     //-----自定义tabbarView

#pragma mark  ===== action =====
-(void)setSelectTabBarItem:(int)selectIndex;    //-----当前选中下标
-(void)showTabBar;                              //-----显示tabbar
-(void)hideTabbar;                              //-----隐藏tabbar
@end
