//
//  GlobalCommon.m
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/30.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import "GlobalCommon.h"

@implementation GlobalCommon

NSString* TrimmedString(NSString *string) {
    
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (trimmedString.length) {
        return trimmedString;
    } else {
        return @"";
    }
}

NSString* TrimmedStringForKeyInRawModel(NSString *key, id rawModel) {
    
    if (![rawModel respondsToSelector:@selector(objectForKey:)]) {
        return @"";
    }
    
    NSString *string = [rawModel objectForKey:key];
    
    if (string == nil || (NSNull *)string == [NSNull null]) {
        return @"";
    } else if (![string isKindOfClass:[NSString class]]) {
        string = [NSString stringWithFormat:@"%@", string];
    }
    
    return TrimmedString(string);
}

NSNumber* TrimmedNumberForKeyInRawModel(NSString *key, id rawModel) {
    
    if (![rawModel respondsToSelector:@selector(objectForKey:)]) {
        return [NSNumber numberWithInt:0];
    }
    
    NSNumber *number = [rawModel objectForKey:key];
    
    if ([number isKindOfClass:[NSNumber class]]) {
        return number;
    }
    
    if ([number respondsToSelector:@selector(doubleValue)]) {
        return [NSNumber numberWithDouble:[number doubleValue]];
    } else if ([number respondsToSelector:@selector(intValue)]) {
        return [NSNumber numberWithInt:[number intValue]];
    } else {
        return [NSNumber numberWithInt:0];
    }
}

@end
