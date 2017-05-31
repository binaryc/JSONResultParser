//
//  Model.m
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/28.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import "Model.h"
#import <objc/runtime.h>
#import "GlobalCommon.h"

@implementation Model

- (instancetype)initWithRawModel:(NSDictionary *)rawModel {
    if (self) {
        [self updateWithRawModel:rawModel];
    }
    return self;
}

- (void)updateWithRawModel:(NSDictionary *)rawModel {
    
    if (![rawModel isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &ivarsCount);
    
    for (int i = 0; i < ivarsCount; i++) {
        
        Ivar ivar = ivars[i];
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        
        NSString *key = TrimmedString([self.rawModelKeyAlias objectForKey:ivarName]);
        key = key.length ? key : ivarName;
        
        if (*type == '@') {
            
            if (!rawModel[key]) {
                continue;
            }
            
            int size = sizeof(type) / sizeof(char);
            char mt[size + 1];
            strcpy(mt, type);
            int i = 0;
            while (*type != '\0') {
                
                if (*type == '@' || *type == '"') {
                    type++;
                    continue;
                }
                
                mt[i] = *type;
                i++;
                type++;
            }
            mt[i] = '\0';
            Class class = objc_getClass(mt);
            
            id obj;
            if ([class isSubclassOfClass:[Model class]]) {
                obj = [[class alloc] initWithRawModel:rawModel[key]];
            } else if (class == [NSString class]) {
                obj = TrimmedStringForKeyInRawModel(key, rawModel);
            } else if (class == [NSNumber class]) {
                obj = TrimmedNumberForKeyInRawModel(key, rawModel);
            } else if ([class isSubclassOfClass:[NSArray class]]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSArray *objs = rawModel[key];
                Class c = [[self collectionGenerics] objectForKey:ivarName];
                if (![objs isKindOfClass:[NSArray class]]) {
                    [arr addObject:rawModel[key]];
                    obj = arr;
                } else if ([c isSubclassOfClass:[Model class]]) {
                    for (id o in objs) {
                        Model *m = [[c alloc] initWithRawModel:o];
                        [arr addObject:m];
                    }
                    obj = arr;
                } else {
                    obj = rawModel[key];
                }
            } else if ([class isSubclassOfClass:[NSSet class]]) {
                NSMutableSet *set = [NSMutableSet set];
                NSArray *objs = rawModel[key];
                Class c = [[self collectionGenerics] objectForKey:ivarName];
                if (![objs isKindOfClass:[NSArray class]]) {
                    [set addObject:rawModel[key]];
                    obj = set;
                } else if ([c isSubclassOfClass:[Model class]]) {
                    for (id o in objs) {
                        Model *m = [[c alloc] initWithRawModel:o];
                        [set addObject:m];
                    }
                    obj = set;
                } else {
                    obj = rawModel[key];
                }
            } else {
                obj = rawModel[key];
            }
            
            object_setIvar(self, ivar, obj);
            
        } else {
            
            ptrdiff_t offset = ivar_getOffset(ivar);
            void *stuffBytes = (__bridge void *)self;
            
            size_t size = 0;
            void *src = NULL;
            void *dst = stuffBytes + offset;
            
            if (*type == 'B') {
                BOOL boolValue = TrimmedNumberForKeyInRawModel(key, rawModel).boolValue;
                size = sizeof(boolValue);
                src = &boolValue;
            } else if (*type == 'i') {
                int intValue = TrimmedNumberForKeyInRawModel(key, rawModel).intValue;
                size = sizeof(intValue);
                src = &intValue;
            } else if (*type == 'f') {
                float floatValue = TrimmedNumberForKeyInRawModel(key, rawModel).floatValue;
                size = sizeof(floatValue);
                src = &floatValue;
            } else if (*type == 'd') {
                double doubleValue = TrimmedNumberForKeyInRawModel(key, rawModel).doubleValue;
                size = sizeof(doubleValue);
                src = &doubleValue;
            } else if (*type == 'q') {
                NSInteger integerValue = TrimmedNumberForKeyInRawModel(key, rawModel).integerValue;
                size = sizeof(integerValue);
                src = &integerValue;
            } else if (*type == 'Q') {
                NSUInteger uintegerValue = TrimmedNumberForKeyInRawModel(key, rawModel).integerValue;
                size = sizeof(uintegerValue);
                src = &uintegerValue;
            }
            
            memcpy(dst, src, size);
        }
    }
    
    free(ivars);
}

- (NSDictionary *)rawModelKeyAlias {
    return @{};
}

- (NSDictionary *)collectionGenerics {
    return @{};
}

@end
