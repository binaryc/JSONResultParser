//
//  GlobalCommon.h
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/30.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalCommon : NSObject

/**
 * @return trimmed string
 */
NSString* TrimmedString(NSString *string);

/**
 * @return trimmed string for key in raw model
 */
NSString* TrimmedStringForKeyInRawModel(NSString *key, id rawModel);

/**
 * @return trimmed number for key in raw model
 */
NSNumber* TrimmedNumberForKeyInRawModel(NSString *key, id rawModel);

@end
