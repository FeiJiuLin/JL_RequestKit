//
//  JL_ConfigInterFace.h
//  RequestKit
//
//  Created by 费九林 on 2019/8/24.
//  Copyright © 2019 费九林. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JL_BodyKeyValues.h"

NS_ASSUME_NONNULL_BEGIN

@interface JL_ConfigInterFace : NSObject

/**
 POST请求

 @param block 设置body
 @param handler 结果回调
 @param error 错误回调
 */
+(void)POST_DataTaskWithUrlBlock:(void(NS_NOESCAPE ^)(JL_BodyKeyValues *body))block
               completionHandler:(void (^)(id results))handler
                          error:(void (^)(NSError *error))error;

/**
 GET请求
 
 @param block 设置body
 @param handler 结果回调
 @param error 错误回调
 */
+(void)GET_DataTaskWithUrlBlock:(void(NS_NOESCAPE ^)(JL_BodyKeyValues *body))block
               completionHandler:(void (^)(id results))handler
                           error:(void (^)(NSError *error))error;


@end

NS_ASSUME_NONNULL_END
