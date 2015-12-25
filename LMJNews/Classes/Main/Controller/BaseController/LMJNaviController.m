//
//  LMJNaviController.m
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJNaviController.h"

@interface LMJNaviController ()

@end

@implementation LMJNaviController


+ (void)initialize
{
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor redColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
