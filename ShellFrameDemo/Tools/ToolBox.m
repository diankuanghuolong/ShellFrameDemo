//
//  ToolBox.m
//  ShellFrameDemo
//
//  Created by Ios_Developer on 2017/12/6.
//  Copyright © 2017年 hai. All rights reserved.

#import "ToolBox.h"
#import "AppDelegate.h"
#import<CommonCrypto/CommonDigest.h>//md5

@implementation ToolBox
+(NSInteger)getYear:(NSDate *)date
{
    //获取当前时间
    NSDate *now = date ? date : [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [dateComponent year];
}
+(NSInteger)getMonth:(NSDate *)date
{
    NSDate *now = date ? date : [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [dateComponent month];
}
+(NSInteger)getDay:(NSDate *)date
{
    NSDate *now = date ? date : [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [dateComponent day];
}
+(NSInteger)getWeek:(NSDate *)date
{
    NSDate *now = date ? date : [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];

    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    if([dateComponent weekday]==1) return 7;
    return [dateComponent weekday] - 1;
}
+(NSString *)formatDate:(NSDate *)date andFormat:(NSString *)format
{
    if (!format || format.length <= 0)
    {
        format = @"yyyy-MM-dd";
    }
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:format]; //用来设置NSDate的输出格式 HH:mm:ss
    
    NSString *setTime=[formatter stringFromDate:date];
    
    return setTime;
}
+(NSDate *)getNSDateFromString:(NSString *)dateString andFormat:(NSString *)format
{
    if (!format || format.length <= 0)
    {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:format]; //用来设置NSDate的输出格式 HH:mm:ss
    
    NSDate * date = [formatter dateFromString:dateString];
    
    return date;
}
/*
 缓存问题
 */
///计算缓存文件的大小的M
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+(NSString *) countCacheSize
{
    NSString  * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cachePath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePath] objectEnumerator];//从前向后枚举器／／／／//
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //        NSLog(@"fileName ==== %@",fileName);
        NSString* fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
        //        NSLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        folderSize += [ToolBox fileSizeAtPath:fileAbsolutePath];
    }
    //    NSLog(@"folderSize ==== %lld",folderSize);
    NSString * str = [[NSString alloc] initWithFormat:@"%.2fM",folderSize/(1024.0 * 1024)];
    return str;
}
+(BOOL) clearCache
{
//    [[SDImageCache sharedImageCache] clearDisk];
//    [[SDImageCache sharedImageCache] clearMemory];
    NSString  * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray * childerFiles = [manager subpathsAtPath:cachePath];
    for (NSString *fileName in childerFiles)
    {
        //如有需要，加入条件，过滤掉不想删除的文件
        NSString *absolutePath = [cachePath stringByAppendingPathComponent:fileName];
        [manager removeItemAtPath:absolutePath error:nil];
        
    }
    return YES;
}
+(CGSize) sizeForLableWithText:(NSString *)strText fontSize:(NSInteger)fontSize withSize:(CGSize)size
{
    CGSize textSize;
    if (!strText) strText = @"";
    NSString *s = strText;
    NSAttributedString *attrStr = [[NSAttributedString  alloc] initWithString:s];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSMutableDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range].mutableCopy;
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    [dic addEntriesFromDictionary:dic1];
    
    // 计算文本的大小
    textSize = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                            attributes:dic        // 文字的属性
                               context:nil].size;
    return textSize;
}

+(BOOL)isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //具体字典里面的key命名是什么 还是得按照你们伟大的服务器人员来
    NSString * content = [defaults objectForKey:@"Session"];
    if (content.length > 0) {
        return YES;
    }
    return NO;
}

//判断是否身份证号码
+(BOOL)isTureStatusNumber:(NSString *)statusNum
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",@"^[1-6]{1}[0-7]{1}[\\d&&[^678]]{1}\\d{1}[\\d&&[^5679]]{1}\\d{1}[1,2]\\d{3}[0,1]\\d{1}[0,1,2,3]\\d{4}[\\d,X,x]$"];
    BOOL is = [predicate evaluateWithObject:statusNum];
    return is;
}
+(void)noticeContent:(NSString *)content andShowView:(UIView *)view andyOffset:(CGFloat)yOffset;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = content;
    hud.label.textColor = UIColorFromHex(0xffffff);
    hud.label.superview.backgroundColor = SystemBlack;
    hud.label.font = [UIFont systemFontOfSize:20];
    hud.label.numberOfLines = 0;
    hud.margin = 8.f;
    hud.offset = CGPointMake(0, yOffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}
+(void)noticeContent:(NSString *)content andShowView:(UIView *)view andyOffset:(CGFloat)yOffset withDelay:(int)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = content;
    hud.label.textColor = UIColorFromHex(0xffffff);
    hud.label.superview.backgroundColor = SystemBlack;
    hud.label.font = [UIFont systemFontOfSize:20];
    hud.label.numberOfLines = 0;
    hud.margin = 8.f;
    hud.offset = CGPointMake(0, yOffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay ? delay : 1];
}

+ (CGSize)getShowImageSize:(UIImage *)image andOrigialSize:(CGSize)size
{
    
    if (image.size.width/image.size.height == size.width/size.height || image.size.width == 0 ||  image.size.height == 0)
    {
        return size;
    }
    CGFloat rate = 1;
    if (size.width/image.size.width < size.height/image.size.height)
    {
        rate = size.width/image.size.width;
    }
    else
    {
        rate = size.height/image.size.height;
    }
    
    return CGSizeMake(image.size.width * rate, image.size.height * rate);

}
+(NSString *)getStrIds:(NSArray *)strs
{
    if (strs.count <= 0) return @"";
    NSMutableString * mstr = [NSMutableString new];
    
    for (NSString * str in strs)
    {
        [mstr appendFormat:@"%@,",str];
    }
    return [mstr substringWithRange:NSMakeRange(0, mstr.length - 1)];
}

+(NSString *)getStrFromArray:(NSArray *)array toKey:(NSString *)key andDividedSymbols:(NSString *)str
{
    if(!array || array.count <= 0) return @"";
    NSMutableString * mstr = [NSMutableString new];
    
    for (NSDictionary * dic in array)
    {
        [mstr appendFormat:@"%@%@",dic[key],str];
    }
    return [mstr substringWithRange:NSMakeRange(0, mstr.length - str.length)];
}

//手机号码中间4为变*
+(NSString *)getEntryPhoneNum:(NSString *)number
{
    if (number.length < 7 ) return number;
    NSMutableString * ms = [[NSMutableString alloc] initWithString:[number substringToIndex:3]];
    for (int i = 0; i < number.length - 7; i ++)
    {
        [ms appendString:@"*"];
    }
    [ms appendString:[number substringFromIndex:number.length - 4]];
    return ms;
}

//
+(NSString *)getStr:(NSString *)str withType:(int)type//0 姓名 1 身份证
{
    NSString *replaceStr = str;
    NSInteger startLocation = 1;
    if ([str isEqualToString:@""] || str == nil)
    {
        return @"";
    }
    
    if (type == 0)//姓名
    {
        for (NSInteger i = 0; i < str.length - 1; i++) {
            NSRange range = NSMakeRange(startLocation, 1);
            replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        }
    }
    else//身份证
    {
        
        for (NSInteger i = 0; i < str.length - 2; i++) {
            NSRange range = NSMakeRange(startLocation, 1);
            replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
            startLocation ++;
        }
    }
    return replaceStr;
}
//判断是否是手机号
+(BOOL)isTruePhone:(NSString *)phoneStr
{
    //移动，联通，电信···
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    NSString * CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[0]|7[8]|8[2-478])\\d{8}$";
    NSString * CU = @"^1(3[0-2]|4[5]|5[56]|709|7[1]|7[6]|8[56])\\d{8}$";
    NSString * CT = @"^1(3[34]|53|77|700|8[019])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneStr] == YES)
        || ([regextestcm evaluateWithObject:phoneStr] == YES)
        || ([regextestct evaluateWithObject:phoneStr] == YES)
        || ([regextestcu evaluateWithObject:phoneStr] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断是否是固定电话话
+ (BOOL)isTelephone:(NSString *)phoneNum {
    
    /**
     
     * 大陆地区固话及小灵通
     
     * 区号：010,020,021,022,023,024,025,027,028,029
     
     * 号码：七位或八位
     
     */
    
    NSString * FT = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", FT];
    
    return [regextestcm evaluateWithObject:phoneNum];
    
}
//判断当前控制器是否正在显示
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

//图片压缩
+(NSData *)imageData:(UIImage *)myimage//图片压缩
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024)
    {
        if (data.length>1024*1024)
        {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }
        else if (data.length>512*1024)
        {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }
        else if (data.length>200*1024)
        {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}
+ (NSData *)imx_compressImage:(UIImage *)img ToSize:(NSInteger)intSize
{
    if (img == nil || ![img isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    NSData * imageData = UIImageJPEGRepresentation(img,1);
    /// 最终要求的大小和目前大小的比
    double fltBeiShu = [imageData length]/1024.00/intSize;
    
    if (fltBeiShu <1) {
        return imageData;
    }
    /// 压缩的次数
    NSInteger intCount = 0;
    NSInteger lastDataLenght = [imageData length];
    while (fltBeiShu > 1) {
        /// 这次压缩的倍数
        imageData = UIImageJPEGRepresentation(img,1);
        fltBeiShu = [imageData length]/1024.00/intSize;
        CGFloat fltBei = 1.0;
        
        for (int a = 0; a<fltBeiShu+intCount; a++) {
            fltBei = fltBei * 0.9;
        }
        /// 这次压缩的倍数
        fltBeiShu = fltBei;
        NSLog(@"系数:%lf",fltBeiShu);
        
        imageData = UIImageJPEGRepresentation(img,fltBeiShu);
        intCount ++;
        /// 跟新要求的大小和目前大小的比
        fltBeiShu = [imageData length]/(intSize * 1024.00);
        NSLog(@"%lf",[imageData length]/1024.00);
        NSLog(@"%lu第%ld次压缩，压缩后的大小%f",(unsigned long)[imageData length],(long)intCount,fltBeiShu);
        
        //如果压缩大小不能再改变（压缩到最大限度），直接返回压缩结果
        if (imageData.length == lastDataLenght)
        {
            imageData = UIImageJPEGRepresentation(img,0.005);
            NSLog(@"压缩到：%ld上次压缩到：%ld",imageData.length,lastDataLenght);
            return imageData;
        }
        
        /// 压缩次数超过四次就压缩到到最大压缩限度
        if (intCount >4) {
            imageData = UIImageJPEGRepresentation(img,0.005);
            return imageData;
        }
        
        lastDataLenght = imageData.length;
    }
    
    return imageData;
}
#pragma mark  ===== label中字体后跟图标  =====
+ (void)setLabelText:(UILabel *)label andImage:(UIImage *)image andBounds:(CGRect)bounds andIsBeforeText:(BOOL)isBeforeText
{
    NSMutableAttributedString * mas = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = bounds;
    NSMutableAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach].mutableCopy;
    
    if (isBeforeText) {
        [attachString appendAttributedString:mas];
        label.attributedText = attachString;
    }
    else{
        [mas appendAttributedString:attachString];
        label.attributedText = mas;
    }
}
//返回到指定控制器
+(void)backToTargetVC:(Class)targetVC fromNowNC:(UINavigationController *)nowNC
{
    for (UIViewController *controller in nowNC.viewControllers) {
        if ([controller isKindOfClass:targetVC]) {
            [nowNC popToViewController:controller animated:YES];
        }
    }
}
#pragma mark ===== json  =====
+(NSDictionary *)getUserInfoDic
{
    NSString *userStr = [[NSString alloc] initWithData:/*(NSData *)*/[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] encoding:NSUTF8StringEncoding];
    
    NSData * data = [userStr dataUsingEncoding:NSUTF8StringEncoding];

    NSDictionary *userInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return userInfoDict;
}
+(BOOL)dataISEmpty:(id)text
{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    return NO;
}

#pragma mark  =====  编码解码  =====
//字符串base64编码
+(NSString *)base64EncodeString:(NSString *)string
{
    // 1.先转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 2.对二进制数据进行base64编码,完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}
//base64解码
+(NSString *)base64DecodeString:(NSString *)string
{
    // 注意:该字符串是base64编码后的字符串
    // 1.转换为二进制数据(完成了解码的过程)
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    // 2.把二进制数据在转换为字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//md5加密小写
+(NSString *)encode_md5:(NSString *)string withLength:(NSInteger)length
{
    
    const char *str = [string UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char digest[/*CC_MD5_DIGEST_LENGTH*/length];
    
    CC_MD5( str, (CC_LONG)strlen(str), digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:/*CC_MD5_DIGEST_LENGTH*/length *2];
    
    for(int i =0; i < /*CC_MD5_DIGEST_LENGTH*/length; i++)
        
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
//md5加密大写
+(NSString *)ecode_MD5:(NSString *)string withLength:(int)length
{
    
    return [ToolBox encode_md5:string withLength:length].uppercaseString;
}
@end
