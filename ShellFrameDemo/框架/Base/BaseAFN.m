//
//  BaseAFN.m
//  BeiWei36du
//
//  Created by Ios_Developer on 2018/2/8.
//  Copyright © 2018年 com.beiWei36du. All rights reserved.
//

#import "BaseAFN.h"

@implementation BaseAFN
+(NSURLSessionDataTask *)downLoadURL:(NSString *)baseURL byParameters:(NSDictionary *)baseParameters withHUBMess:(NSString *)hubText andShowInView:(UIView *)ShowInView success:(void (^)(id  _Nonnull responseObject))baseSuccess failure:(void (^)(NSError * _Nonnull error))baseFailure
{
    //请求接口提交
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ShowInView animated:YES];
    hud.label.text = hubText;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 8.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSURLSessionDataTask * task = [manager POST:baseURL parameters:baseParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(baseSuccess)
            baseSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(baseFailure)
            baseFailure(error);
        if (error.code == -1001)
        {
            [ToolBox noticeContent:@"请求超时" andShowView:ShowInView andyOffset:SCREEN_HEIGHT/2 - SafeAreaBottomHeight - 200];
        }
        else
        {
            [ToolBox noticeContent:@"请求服务器失败" andShowView:ShowInView andyOffset:SCREEN_HEIGHT/2 - SafeAreaBottomHeight - 200];
        }
        NSLog(@"error.code == %ld  BaseError == %@",(long)error.code,error);
    }];
    
    return task;
}
@end
