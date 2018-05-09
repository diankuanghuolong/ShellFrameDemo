//
//  ToolBox.h
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
@interface ToolBox : NSObject
//获取今天是某年某月某日
+(NSInteger)getYear:(NSDate *)date;
+(NSInteger)getMonth:(NSDate *)date;
+(NSInteger)getDay:(NSDate *)date;
+(NSInteger)getWeek:(NSDate *)date;
+(NSString *)formatDate:(NSDate *)date andFormat:(NSString *)format;
+(NSDate *)getNSDateFromString:(NSString *)dateString andFormat:(NSString *)format;

//缓存问题
+(NSString *) countCacheSize;
+(BOOL) clearCache;
//计算绘制文本需要的空间
+(CGSize) sizeForLableWithText:(NSString *)strText fontSize:(NSInteger)fontSize withSize:(CGSize)size;
//判断是否登录状态
+(BOOL)isLogin;
//判断是否身份证号码
+(BOOL)isTureStatusNumber:(NSString *)statusNum;
//网络加载返回提示信息显示框
+(void)noticeContent:(NSString *)content andShowView:(UIView *)view andyOffset:(CGFloat)yOffset;
//网络加载返回提示信息显示框+自定义延迟时间
+(void)noticeContent:(NSString *)content andShowView:(UIView *)view andyOffset:(CGFloat)yOffset withDelay:(int)delay;

+ (CGSize)getShowImageSize:(UIImage *)image andOrigialSize:(CGSize)size;

//获取，字符串
+(NSString *)getStrIds:(NSArray *)strs;
+(NSString *)getStrFromArray:(NSArray *)array toKey:(NSString *)key andDividedSymbols:(NSString *)str;

//手机号码中间4为变*
+(NSString *)getEntryPhoneNum:(NSString *)number;
+(NSString *)getStr:(NSString *)str withType:(int)type;//0 姓名 1 身份证 （修改姓名除了第一位外改为*只适用中文3个字内的姓名 ------ 修改身份证除第一位和最后一位外改为*）

//判断是否为手机号
+(BOOL)isTruePhone:(NSString *)phoneStr;
//判断是否是固定电话话
+ (BOOL)isTelephone:(NSString *)phoneNum;
//修改字符串某段为*
#pragma warmming 待加入

////判断当前控制器是否正在显示
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

//图片压缩
+(NSData *)imageData:(UIImage *)myimage;
+ (NSData *)imx_compressImage:(UIImage *)img ToSize:(NSInteger)intSize;

//label 后面或前面添加图片
+ (void)setLabelText:(UILabel *)label andImage:(UIImage *)image andBounds:(CGRect)bounds andIsBeforeText:(BOOL)isBeforeText;

//返回到指定控制器
+(void)backToTargetVC:(Class)targetVC fromNowNC:(UINavigationController *)nowNC;

//获取用户信息
+(NSDictionary *)getUserInfoDic;

//判断返回数据是否为null
+(BOOL)dataISEmpty:(id)text;

//md5加密小写
+(NSString *)encode_md5:(NSString *)string withLength:(NSInteger)length;
//md5加密小写
+(NSString *)ecode_MD5:(NSString *)string withLength:(int)length;
@end
