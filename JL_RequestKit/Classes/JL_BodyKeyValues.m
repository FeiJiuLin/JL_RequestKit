//
//  JL_BodyKeyValues.m
//  RequestKit
//
//  Created by 费九林 on 2019/8/24.
//  Copyright © 2019 费九林. All rights reserved.
//

#import "JL_BodyKeyValues.h"
#import <objc/message.h>

@interface JL_BodyKeyValues ()

@property (nonatomic, strong) NSMutableDictionary *body_Dictionary;

@end

@implementation JL_BodyKeyValues

- (instancetype)init
{
    self = [super init];
    if (self) {
        _body_Dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (body_keyValue)key_value
{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *key, id value){
        if (key) {
            [weakSelf.body_Dictionary setValue:value forKey:key];
        }
        return weakSelf;
    };
}

- (body_dictionary)body_dic
{
    __weak typeof(self) weakSelf = self;
    return ^(NSDictionary *dic) {
        [weakSelf.body_Dictionary addEntriesFromDictionary:dic];
        return weakSelf;
    };
}

- (body_model)body_model
{
    __weak typeof(self) weakSelf = self;
    return ^(id models){
        if ([models isKindOfClass:[NSObject class]]) {
            NSObject *obj = models;
            NSDictionary *Values = [weakSelf dicFromObject:obj];
            [weakSelf.body_Dictionary addEntriesFromDictionary:Values];
        }
        return weakSelf;
    };
    
}

- (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setValue:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setValue:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
            
        } else if (value == nil) {
            
        } else {
            //model
            [dic setValue:[self dicFromObject:value] forKey:name];
        }
    }
    
    free(propertyList);//释放对象
    
    return [dic copy];
}

//将可能存在model数组转化为普通数组
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
                
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        
        return [array copy];
        
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setValue:object forKey:key];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setValue:[self arrayOrDicWithObject:object] forKey:key];
                
            } else {
                //model
                [dic setValue:[self dicFromObject:object] forKey:key];
            }
        }
        
        return [dic copy];
    }
    
    return [NSNull null];
}

@end
