//
//  Model.h
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/28.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RawModelParser <NSObject>

@optional

/*
    将JSON中key与对应的Model类中的属性一一对应，
    如：@{@"modelPropertyName" : @"JSONKey"}Model类中的属性会自动根据JSONKey解析数据，
    若不实现该方法或返回空将自动根据Model类中属性名解析JSON数据。
 */
- (NSDictionary *)rawModelKeyAlias;

/*
    Model类中集合属性根据提供泛型解析JSON数据，
    如：@{@"modelPropertyName" : Class}Model类中集合会自动根据class解析JSON数据，
    若不实现该方法或返回空将JSON中对应Array赋值给对应Model集合属性。
 */
- (NSDictionary *)collectionGenerics;

@end

@interface Model : NSObject <RawModelParser>

- (instancetype)initWithRawModel:(NSDictionary *)rawModel;
- (void)updateWithRawModel:(NSDictionary *)rawModel;

@end
