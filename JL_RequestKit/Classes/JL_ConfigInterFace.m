//
//  JL_ConfigInterFace.m
//  RequestKit
//
//  Created by 费九林 on 2019/8/24.
//  Copyright © 2019 费九林. All rights reserved.
//

#import "JL_ConfigInterFace.h"

@implementation JL_ConfigInterFace

+(void)POST_DataTaskWithUrlBlock:(void(NS_NOESCAPE ^)(JL_BodyKeyValues *body))block
               completionHandler:(void (^)(id results))handler
                           error:(void (^)(NSError *error))error
{
    JL_BodyKeyValues *key_value = [[JL_BodyKeyValues alloc] init];
    block(key_value);
    //5
}


+(void)GET_DataTaskWithUrlBlock:(void(NS_NOESCAPE ^)(JL_BodyKeyValues *body))block
               completionHandler:(void (^)(id results))handler
                           error:(void (^)(NSError *error))error
{
    JL_BodyKeyValues *key_value = [[JL_BodyKeyValues alloc] init];
    block(key_value);
    //5
}


@end
