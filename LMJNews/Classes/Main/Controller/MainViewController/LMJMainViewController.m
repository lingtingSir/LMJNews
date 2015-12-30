//
//  LMJMainViewController.m
//  LMJNews
//
//  Created by lmj on 15/12/23.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJMainViewController.h"
#import "LMJNewsTableViewController.h"
#import "LMJTitleLabel.h"
#import "LMJWeatherView.h"
#import "LMJWeatherDetailVC.h"
#import "UIView+Extension.h"
#import "LMJWeatherModel.h"
#import "LMJHTTPManager.h"
#import <MJExtension.h>

@interface LMJMainViewController ()

// 导航标题
@property (weak, nonatomic) IBOutlet UIScrollView *smallScollView;

// 内容
@property (weak, nonatomic) IBOutlet UIScrollView *bigScollView;
@property (nonatomic,strong) LMJTitleLabel *oldTitleLabel;
@property (nonatomic,assign) CGFloat beginOffsetX;

// 新闻接口的数组
@property (nonatomic,strong) NSArray *arrayLists;
@property (nonatomic,assign,getter=isWetherShow) BOOL weatherShow;
@property (nonatomic,strong) LMJWeatherView *weatherView;
@property (nonatomic,strong) UIImageView *tran;
@property (nonatomic,strong) LMJWeatherModel *weatherModel;
@property (nonatomic,strong) UIButton *rightItem;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopToTop;

@end

@implementation LMJMainViewController

#pragma mark - arrayLists懒加载
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    // 容错一个BUG先消失RightItem,在显示
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"top20"]) {
        self.TopToTop.constant = 20;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"top20"];
    } else {
        self.TopToTop.constant = 0;
    }
    self.rightItem.hidden = NO;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rightItem"]) {
        self.rightItem.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"rightItem"];
        
    }
    self.rightItem.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.rightItem.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"rightItem"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.rightItem.hidden = YES;
    self.rightItem.transform = CGAffineTransformIdentity;
    [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
}

- (void)showRightItem
{
    self.rightItem.hidden = NO;
}

#pragma mark - 添加方法
#pragma mark 添加子控制器
- (void)addController
{
    for (int i = 0; i < self.arrayLists.count; i++) {
       
    }
}




@end
