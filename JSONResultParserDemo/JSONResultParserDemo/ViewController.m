//
//  ViewController.m
//  JSONResultParserDemo
//
//  Created by 陈彬 on 2017/5/31.
//  Copyright © 2017年 陈彬. All rights reserved.
//

#import "User.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *rawUser = @{@"uid" : @"1001", @"n" : @"陈彬", @"a" : @27, @"bfs" : @[@{@"uid" : @"1002", @"n" : @"Hello", @"a" : @28}]};
    User *u = [[User alloc] initWithRawModel:rawUser];
    NSLog(@"user id %@ name %@ age %d bestFriends %@", u.userID, u.name, u.age, u.bestFriends);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
