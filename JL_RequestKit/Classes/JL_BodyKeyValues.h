//
//  JL_BodyKeyValues.h
//  RequestKit
//
//  Created by 费九林 on 2019/8/24.
//  Copyright © 2019 费九林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JL_BodyKeyValues : NSObject

typedef JL_BodyKeyValues *_Nonnull (^body_keyValue)(NSString * key, id value);

typedef JL_BodyKeyValues *_Nonnull (^body_dictionary)(NSDictionary * dic);

typedef JL_BodyKeyValues *_Nonnull (^body_model)(id  models);

/**
 设置键值对
 */
@property (nonatomic, copy, readonly) body_keyValue _Nonnull key_value;

/**
 设置字典
 */
@property (nonatomic, copy, readonly) body_dictionary _Nonnull body_dic;

/**
 设置模型 模型的继承类必须要是NSObject 否则无效
 */
@property (nonatomic, copy, readonly) body_model _Nonnull body_model;


@end

NS_ASSUME_NONNULL_END
