//
//  LunchVC.m
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.
//

#import "LaunchVC.h"
#import "AppDelegate.h"
/*
  屏幕宽高宏定义
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark  ===== colors =====
/*
 //16进制颜色给色方法
 #define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
 //RGB颜色给色方法 略
 */

#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]

@interface LaunchVC ()<UIScrollViewDelegate>
{
    CGFloat _startX;
    CGFloat _endX;
    UIButton *_gotoHomeBtn;
}

@property(nonatomic,strong)UIScrollView *sv;
@property(nonatomic,strong)UIPageControl *pc;
@end

@implementation LaunchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _startX = 0;
    _endX = 0;
    
    [self loadScrollView];
}

#pragma mark ===== 用scrollview作为引导页面 =====
/*
    引导页面如果选择动画效果，有两种实现方案
    方案一： 在sv上添加gif图
    方案二： 使用动画实现 当前给出使用动画实现的一个例子
 */
- (void)loadScrollView
{
    if (!_sv)
    {
        _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _sv.pagingEnabled = YES;
        _sv.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
        _sv.contentOffset = CGPointMake(0, 0);
        _sv.showsHorizontalScrollIndicator = NO;
        _sv.delegate = self;
        [self.view addSubview:_sv];
        
        UIPageControl * pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH)/2 + SCREEN_WIDTH + 60, _sv.frame.size.width, 20)];
        pageC.enabled = NO;
        pageC.numberOfPages = 4;
        pageC.currentPage = 0;
        pageC.hidesForSinglePage = YES;
        pageC.pageIndicatorTintColor = UIColorFromHex(0xb4dfc7);
        pageC.currentPageIndicatorTintColor = UIColorFromHex(0x409569);
        [pageC updateCurrentPageDisplay];
        [self.view addSubview:pageC];
        _pc = pageC;
        
        //引导页面titles
        NSArray *titleArr = @[@"第一个引导页面",@"第二个引导页面",@"第三个引导页面式",@"第四个引导页面"];
        for (int i = 0; i <titleArr.count; i ++)
        {
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15 + SCREEN_WIDTH * i, 50, SCREEN_WIDTH - 30, 40)];
            titleL.text = titleArr[i];
            titleL.font = [UIFont systemFontOfSize:18];
            titleL.textColor = [UIColor blackColor];
            titleL.textAlignment = NSTextAlignmentCenter;
            [_sv addSubview:titleL];
        }
        
        //引导页面图片 gif 或者 背景图片，背景图上控件 加动画实现
        NSArray *imgArr = @[@"",@"",@"",@""];
        for (int i = 0; i < imgArr.count; i ++)
        {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, (SCREEN_HEIGHT - SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
            iv.backgroundColor = [UIColor whiteColor];
            iv.tag = 100 + i;
            iv.image = [UIImage imageNamed:imgArr[i]];
            [_sv addSubview:iv];
            
            if (i ==0)
            {
                [self page1Animation:NO];
            }
        }
    }
}

#pragma mark  ===== action  =====
/*
    点击事件
 */

#pragma mark -- svDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //此处处理sv的切换，pageCtr的切换
    
    
    int pageNum = scrollView.contentOffset.x/SCREEN_WIDTH;
    _pc.currentPage = pageNum;
    if (scrollView.contentOffset.x > SCREEN_WIDTH * 3 + 20)
    {
        //进入首页
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.view.window.rootViewController = appDelegate.tbC;
    }
}

#pragma mark  =====  animation  =====
-(void)page1Animation:(BOOL)left//page1 由左侧进入时
{
//    [self stopAllAnimation];
    UIImageView *iv = [_sv viewWithTag:100];
    
    for (UIView *subV in iv.subviews) {
        [subV removeFromSuperview];
    }
    
    if (left)
    {
        //创建运转动画
        UIGraphicsBeginImageContext(CGSizeMake(iv.frame.size.width,iv.frame.size.height));
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = 1.0;
        pathAnimation.repeatCount = 1;
        //设置运转动画的路径
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        CGPathAddArc(curvedPath, NULL, iv.frame.size.width/2 , iv.frame.size.width/2, (iv.frame.size.width - 72)/2 , 270 / 180.0 * M_PI, 340 / 180.0 * M_PI, 0);
        //顺时针, 0);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        
        UIImageView *sunIV = [[UIImageView alloc] initWithFrame:CGRectMake(iv.frame.size.width/2, 0, 60, 60)];
        sunIV.image = [UIImage imageNamed:@"page1_guide_2"];
        [iv addSubview:sunIV];
        
        [sunIV.layer addAnimation:pathAnimation forKey:@"moveTheCircleOneLeft"];
        
        //太阳大小
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        sunIV.transform=CGAffineTransformMakeScale(1.5, 1.5);
        [UIView commitAnimations];
        
        //云层
        UIImageView *cloudIV = [[UIImageView alloc] initWithFrame:CGRectMake(52, 60, iv.frame.size.width - 52* 2, (iv.frame.size.width - 52* 2) * 256 / 905)];
        cloudIV.image = [UIImage imageNamed:@"page1_guide_3"];
        [iv addSubview:cloudIV];
    }
    else
    {
        //创建运转动画
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        /*备注信息（17.7.6）
         kCAAnimationPaced 使得动画均匀进行
         http://www.jianshu.com/p/c18588d4104a
         */
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = 1.0;
        pathAnimation.repeatCount = 1;
        /*备注信息（17.7.6）
         removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
         */
        //设置运转动画的路径
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        CGPathAddArc(curvedPath, NULL, iv.frame.size.width/2, iv.frame.size.width/2, (iv.frame.size.width - 72)/2 , 340 / 180.0 * M_PI, 270 / 180.0 * M_PI, 1);
        //逆时针, 1);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        
        UIImageView *sunIV = [[UIImageView alloc] initWithFrame:CGRectMake(iv.frame.size.width, iv.frame.size.height/2, 60*1.5, 60*1.5)];
        sunIV.image = [UIImage imageNamed:@"page1_guide_2"];
        [iv addSubview:sunIV];
        
        [sunIV.layer addAnimation:pathAnimation forKey:@"moveTheCircleOneRight"];
        
        //太阳大小
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        sunIV.transform = CGAffineTransformMakeScale(0.7, 0.7);
        [UIView commitAnimations];
        
        //云层
        UIImageView *cloudIV = [[UIImageView alloc] initWithFrame:CGRectMake(52, 60, iv.frame.size.width - 52* 2, (iv.frame.size.width - 52* 2) * 256 / 905)];
        cloudIV.image = [UIImage imageNamed:@"page1_guide_3"];
        [iv addSubview:cloudIV];
    }
    
}
-(void)page3Animation:(BOOL)left
{
//    [self stopAllAnimation];
    UIImageView *iv = [_sv viewWithTag:102];
    for (UIView *subV in iv.subviews) {
        [subV removeFromSuperview];
    }
    
    if (left)
    {
        UIImageView *personIV = [[UIImageView alloc] initWithFrame:CGRectMake(iv.frame.size.width - iv.frame.size.width/2, (iv.frame.size.height - iv.frame.size.width/6 * 235 / 125)/2 + 40, iv.frame.size.width/6, iv.frame.size.width/6 * 235 / 125)];
        personIV.image = [UIImage imageNamed:@"page3_guide_2"];
        [iv addSubview:personIV];
        
        
        //帧动画
        [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/5.0 animations:^{
                personIV.frame = CGRectMake(iv.frame.size.width - 5 * iv.frame.size.width/10, personIV.frame.origin.y, personIV.frame.size.width, personIV.frame.size.height);
                
            }];
            [UIView addKeyframeWithRelativeStartTime:1/5.0 relativeDuration:1/5.0 animations:^{
                personIV.frame = CGRectMake(iv.frame.size.width - 4 * iv.frame.size.width/10, personIV.frame.origin.y, personIV.frame.size.width, personIV.frame.size.height);
                
            }];
            [UIView addKeyframeWithRelativeStartTime:2/5.0 relativeDuration:1/5.0 animations:^{
                personIV.frame = CGRectMake(iv.frame.size.width - 3 * iv.frame.size.width/10, personIV.frame.origin.y, personIV.frame.size.width, personIV.frame.size.height);
                
            }];
            [UIView addKeyframeWithRelativeStartTime:3/5.0 relativeDuration:1/5.0 animations:^{
                personIV.frame = CGRectMake(iv.frame.size.width - 2 * iv.frame.size.width/10, personIV.frame.origin.y, personIV.frame.size.width, personIV.frame.size.height);
                
            }];
            [UIView addKeyframeWithRelativeStartTime:4/5.0 relativeDuration:1/5.0 animations:^{
                personIV.frame = CGRectMake(iv.frame.size.width, personIV.frame.origin.y, personIV.frame.size.width, personIV.frame.size.height);
            }];
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
       //同理，反向动画
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
