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

@interface LMJMainTabBarController () <LMJTabBarDelegate>

@end

@implementation LMJMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [LMJAddManager loadLatestAddImage];
    if ([LMJAddManager isShouldDisplayAdd]) {
        //
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"top20"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rightItem"];
        
        UIView *addView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIImageView *addImg = [[UIImageView alloc] initWithImage:[LMJAddManager getAddImage]];
        UIImageView *addBottomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adBottom.png"]];
        [addView addSubview:addBottomImg];
        [addView addSubview:addImg];
        addBottomImg.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
        addImg.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
        
        addView.alpha = 0.99f;
        [self.view addSubview:addView];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [UIView animateWithDuration:3 animations:^{
            addView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [UIView animateWithDuration:0.5 animations:^{
                addView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [addView removeFromSuperview];
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LMJAdvertisementKey" object:nil];
        }];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
    }
    
//    LMJTabBar *tabBar = [[LMJTabBar alloc] init];
//    tabBar.frame = self.tabBar.bounds;
//  
//    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.tabBar addSubview:tabBar];
//    tabBar.delegate = self;
//    [tabBar addImageView];
//    self.selectedIndex = 0;
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [super viewWillAppear:animated];
    

}


#pragma mark - LMJTabBarDelegate 
- (void)ChangeSelIndexFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}


@end
