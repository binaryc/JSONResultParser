//
//  User.m
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/30.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import "User.h"

@implementation User

- (NSDictionary *)rawModelKeyAlias {
    return @{@"userID" : @"uid", @"name" : @"n", @"age" : @"a", @"bestFriends" : @"bfs"};
}

- (NSDictionary *)collectionGenerics {
    return @{@"bestFriends" : [User class]};
}

@end
