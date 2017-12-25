//
//  TabBarVC.m
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "BaseNavigationCtr.h"
#import "HomeVC.h"
#import "CommunityVC.h"
#import "PersonCenterVC.h"

#define Line_H 0.2f
#define tabbarItemUnSelectColor [UIColor blackColor]//未选中tabbarItem的颜色 当前设置为黑色
#define tabbarItemSelectColor [UIColor redColor];//选中tabbarItem的颜色，当前设置为红色
#define tabbarItemTieleColor [UIColor redColor];//tabbarItem字体颜色 当前设置为红色
@interface BaseTabBarVC ()

#pragma mark  ===== action  =====
-(void)customTabbarView;                                //自定义tabbarView
-(void)selectTabBarItem:(UITapGestureRecognizer *)tap;  //tababr点击事件
@end

@implementation BaseTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init datas ----- 定制tabbar img selectedImg titles （例：首页，社区，个人中心）
    _images = @[@"",@"",@""];
    _selectImages = @[@"",@"",@""];
    _titles = @[@"首页",@"社区",@"我的"];
    
    //init views  ------管理各个导航 navigationController
    [self loadVCs];
    self.selectedIndex = 0;
    [self customTabbarView];
}

#pragma mark  ===== 管理各个导航 navigationController 并自定义tabbarView =====
/*
    试图控制器管理方案
    将window的rooterViewController交给tabbar， 通过tabbar 管理 nav ，然后通过nav管理vc
    即：
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = [BaseTabbarController new];
 
        window.rooterViewController = tabbar -> tabbar.rooterViewController = nav -> nav.rooterViewController = vc
 */

-(void)loadVCs
{
    //import 各个控制器并new初始化
    /*
     例：
     */
    HomeVC * homeVC = [HomeVC new];
    CommunityVC * communityVC = [CommunityVC new];
    PersonCenterVC * personCenterVC = [PersonCenterVC new];
    
    //import 各个导航控制器并new初始化
    /*
     例：
     */
    BaseNavigationCtr * homeNC = [[BaseNavigationCtr alloc] initWithRootViewController:homeVC];
    BaseNavigationCtr * communityNC = [[BaseNavigationCtr alloc] initWithRootViewController:communityVC];
    BaseNavigationCtr * personCenterNC = [[BaseNavigationCtr alloc] initWithRootViewController:personCenterVC];
    self.viewControllers = @[homeNC,communityNC,personCenterNC];
}
//自定义tabbar
-(void)customTabbarView
{
    CGRect rect = self.tabBar.bounds;
    //自定义
    _bgView = [[UIView alloc] initWithFrame:rect];
    _bgView.backgroundColor = [UIColor whiteColor];
    //line
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    lineV.backgroundColor = [UIColor darkGrayColor];
    [_bgView addSubview:lineV];
    
    [self.tabBar setBackgroundColor:[UIColor clearColor]];
    [self.tabBar addSubview:_bgView];
    
    CGFloat x = 0,y = 0;//Line_H;
    for (int i = 0;i < self.viewControllers.count; i++)
    {
        BaseTabBarItem * tbI = [[BaseTabBarItem alloc] initWithFrame:CGRectMake(x, y, CGRectGetWidth(_bgView.frame)/self.viewControllers.count, CGRectGetHeight(_bgView.frame)-Line_H)];
        tbI.imageView.image = [UIImage imageNamed:_images[i]];
        tbI.tag = 10 + i;
        tbI.titleLabel.text = _titles[i];
        x += CGRectGetWidth(_bgView.frame)/self.viewControllers.count;
        if (self.selectedIndex == i)
        {
            tbI.imageView.image = [UIImage imageNamed:_selectImages[i]];
            tbI.titleLabel.textColor = tabbarItemTieleColor;
        }
        //add gesturerecognizer
        [tbI addTapGestureRecognizer:self action:@selector(selectTabBarItem:)];
        //
        [_bgView addSubview:tbI];
    }
    
}
-(void)selectTabBarItem:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == self.selectedIndex + 10)return;
    else
    {
        
        BaseTabBarItem * tbi = (BaseTabBarItem *)[_bgView viewWithTag:10 + self.selectedIndex];
        //取消当前选中
        tbi.imageView.image = [UIImage imageNamed:_images[self.selectedIndex]];
        tbi.titleLabel.textColor = tabbarItemUnSelectColor;
        //改变新选中的
        self.selectedIndex = tap.view.tag - 10;
        ((BaseTabBarItem *)(tap.view)).imageView.image = [UIImage imageNamed:_selectImages[self.selectedIndex]];
        ((BaseTabBarItem *)(tap.view)).titleLabel.textColor = tabbarItemSelectColor;
    }
    
}
-(void)setSelectTabBarItem:(int)selectIndex
{
    if (selectIndex == self.selectedIndex)return;
    else
    {
        
        BaseTabBarItem * tbi = (BaseTabBarItem *)[_bgView viewWithTag:10 + self.selectedIndex];
        //取消当前选中
        tbi.imageView.image = [UIImage imageNamed:_images[self.selectedIndex]];
        tbi.titleLabel.textColor = tabbarItemUnSelectColor;
        //改变新选中的
        self.selectedIndex = selectIndex;
        BaseTabBarItem * newTbi = (BaseTabBarItem *)[_bgView viewWithTag:10 + selectIndex];
        newTbi.imageView.image = [UIImage imageNamed:_selectImages[self.selectedIndex]];
        newTbi.titleLabel.textColor = tabbarItemSelectColor;
    }
    
}
//tabbar's show and hide
-(void)showTabBar
{
    for (UIView * view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = NO;
            break;
        }
    }
}
-(void)hideTabbar
{
    for (UIView * view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
