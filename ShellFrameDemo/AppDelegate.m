//
//  AppDelegate.m
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import "AppDelegate.h"


/*
   1. 导入baseTabbarVC 和 launchVC 进入app视图
   2. 宏定义所需颜色，大小等属性变量
 */

#import "LaunchVC.h"

#define NavBarTitleColor [UIColor blackColor] // --------------- 系统风格导航栏字体颜色，当前置为黑色
#define NavBarTitleFont [UIFont systemFontOfSize:18.f]  // ----- 系统风格导航栏字体大小，当前置为18

@interface AppDelegate ()

/*
 定义所需属性变量
 */
@property(nonatomic,strong)LaunchVC *launchVC;

@end

@implementation AppDelegate
#pragma mark ===== 懒加载 tabbar  launchVC  =====
-(BaseTabBarVC *)tbC
{
    if (!_tbC)
    {
        _tbC = [BaseTabBarVC new];
    }
    return _tbC;
}
-(LaunchVC *)launchVC
{
    if (!_launchVC)
    {
        _launchVC = [LaunchVC new];
    }
    return _launchVC;
}
#pragma mark  ===== 系统风格-导航／状态栏设置  =====
-(void)customizeNavigaitonBarAppearance
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg_white"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:NavBarTitleColor,NSForegroundColorAttributeName,NavBarTitleFont,NSFontAttributeName,nil]];
    [UINavigationBar appearance].translucent = YES;
}

#pragma mark
#pragma mark ===== 加载  =====
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /*
      进入app设置：
        1.设置系统风格 - 导航／状态栏
        2.第三方注册
        3.判断是否第一次进入（是否安装），是，进入首页；否，进入引导页面
     */
    
    //1.设置系统风格 - 导航／状态栏
    [self customizeNavigaitonBarAppearance];
    
    //2.第三方注册
    [self regisformInfo:launchOptions];
    
    //3.判断是否第一次进入（是否安装），是，进入首页；否，进入引导页面
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSUserDefaults * uds = [NSUserDefaults standardUserDefaults];
    NSString * sysCurrentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//----- 系统版本信息
    NSString * currentVersion = [uds objectForKey:@"current_version"];//存取当前版本号，如果与系统版本相同，说明不是第一次启动，不存在或不同说明是第一次启动 ／"current_version" 建议在pch中宏定义（pch中定义后，此处替换）
    
    if (!currentVersion || ![sysCurrentVersion isEqualToString:currentVersion])
    {
        [uds setObject:sysCurrentVersion forKey:@"current_version"];//----- "current_version" 建议在pch中宏定义（pch中定义后，此处替换）
        //goto guide vc
        self.window.rootViewController = self.launchVC;
    }
    else
    {
        self.window.rootViewController = self.tbC;
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark
#pragma mark  ===== 注册第三方  =====
-(void)regisformInfo:(NSDictionary *)launchOptions
{
    
}

@end
