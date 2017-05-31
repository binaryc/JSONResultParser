//
//  User.h
//  BNCFoundation
//
//  Created by 陈彬 on 2017/5/30.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import "Model.h"

@interface User : Model

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSArray *bestFriends;

@end
