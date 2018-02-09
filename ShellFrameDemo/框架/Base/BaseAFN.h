//
//  BaseAFN.h
//  BeiWei36du
//
//  Created by Ios_Developer on 2018/2/8.
//  Copyright © 2018年 com.beiWei36du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAFN : NSObject

+(NSURLSessionDataTask *_Nullable)downLoadURL:(NSString *_Nullable)baseURL byParameters:(NSDictionary *_Nullable)baseParameters withHUBMess:(NSString *_Nullable)hubText andShowInView:(UIView *_Nullable)ShowInView success:(nullable void (^)(id  _Nonnull responseObject))baseSuccess failure:(void (^_Nullable)(NSError * _Nonnull error))baseFailure;

@end
