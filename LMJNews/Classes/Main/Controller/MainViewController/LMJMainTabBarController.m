//
//  LMJMainTabBarController.m
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJMainTabBarController.h"
#import "LMJBarButton.h"
#import "LMJTabBar.h"
#import "LMJMainViewController.h"
#import "LMJNaviController.h"
#import "LMJAddManager.h"
#import "UIView+Extension.h"
@interface LMJMainTabBarController ()

@end

@implementation LMJMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LMJAddManager loadLatestAddImage];
    if ([LMJAddManager isShouldDisplayAdd]) {
        //
    }
}


@end
