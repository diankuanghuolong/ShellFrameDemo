//
//  AppDelegate.h
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)BaseTabBarVC *tbC;//-----tbc 开放出来，方便其他地方使用
@end

