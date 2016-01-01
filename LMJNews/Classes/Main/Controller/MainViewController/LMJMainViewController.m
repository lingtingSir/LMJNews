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

@interface LMJMainViewController () <UIScrollViewDelegate>

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
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsUrls.plist" ofType:nil]];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRightItem) name:@"LMJAdvertisementiKey" object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScollView.showsHorizontalScrollIndicator = NO;
    self.smallScollView.showsVerticalScrollIndicator = NO;
    self.bigScollView.delegate = self;
    [self addController];
    [self addLabel];
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScollView.bounds;
    [self.bigScollView addSubview:vc.view];
    LMJTitleLabel *label = [self.smallScollView.subviews firstObject];
    label.scale = 1.0;
    self.bigScollView.showsHorizontalScrollIndicator = NO;
    
    UIButton *rightItem = [[UIButton alloc] init];
    self.rightItem = rightItem;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [win addSubview:rightItem];
    rightItem.y = 20;
    rightItem.width = 45;
    rightItem.height = 45;
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    [rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
//    [self send]
}

- (void)viewWillAppear:(BOOL)animated
{
//    if([[NSUserDefaults standardUserDefaults]boolForKey:@"top20"]){
//        self.TopToTop.constant = 20;
//        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"top20"];
//    }else{
//        self.TopToTop.constant = 0;
//    }
//    self.rightItem.hidden = NO;
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rightItem"]) {
//        self.rightItem.hidden = YES;
//        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"rightItem"];
//    }
//    self.rightItem.alpha = 0;
//    [UIView animateWithDuration:0.4 animations:^{
//        self.rightItem.alpha = 1;
//    }];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
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
        LMJNewsTableViewController *vc1 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        vc1.title = self.arrayLists[i][@"title"];
        vc1.urlString = self.arrayLists[i][@"urlString"];
        [self addChildViewController:vc1];
    }
}
#pragma mark 添加标题栏
- (void)addLabel
{
    for (int i = 0; i < 8; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        LMJTitleLabel *lbl1 = [[LMJTitleLabel alloc] init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text = vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.smallScollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScollView.contentSize = CGSizeMake(70 * 8, 0);
}

#pragma mark 标题栏的label点击事件
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    LMJTitleLabel *titleLabel = (LMJTitleLabel *)recognizer.view;
    CGFloat offsetX = titleLabel.tag * self.bigScollView.frame.size.width;
    CGFloat offsetY = self.bigScollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self.bigScollView setContentOffset:offset animated:YES];
}
#pragma mark - ScrollViewDelegate
#pragma mark 滚动结束后调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    NSLog(@"scrollView.contentOffset.x--!%lf",scrollView.contentOffset.x);
//    NSLog(@"self.bigScollView.frame.size.width---!%lf",self.bigScollView.frame.size.width);
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScollView.frame.size.width;
    
    // 滚动标题栏
    LMJTitleLabel *titleLabel = (LMJTitleLabel *)self.smallScollView.subviews[index];
//    NSLog(@"titleLabel.center.x--!%lf",titleLabel.center.x);
    CGFloat offsetX = titleLabel.center.x - self.smallScollView.frame.size.width * 0.5; //
//    NSLog(@"self.smallScollView.contentSize.width---!%lf",self.smallScollView.contentSize.width);
//    NSLog(@"self.smallScollView.frame.size.width--!%lf",self.smallScollView.frame.size.width);
    CGFloat offsetW = self.smallScollView.contentSize.width - self.smallScollView.frame.size.width; //
//    NSLog(@"offsetX:%lf  offsetW:%lf",offsetX,offsetW);
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > offsetW) {
        offsetX = offsetW;
    }
    
    CGPoint offset = CGPointMake(offsetX, self.smallScollView.contentOffset.y);
    [self.smallScollView setContentOffset:offset animated:YES];
    // 添加控制器
    LMJNewsTableViewController *newsVC = self.childViewControllers[index];
    [self.smallScollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            LMJTitleLabel *tempLabel = self.smallScollView.subviews[idx];
            tempLabel.scale = 0.0;
        }
    }];
    if (newsVC.view.superview) {
        return;
    }
    newsVC.view.frame = scrollView.bounds;
    [self.bigScollView addSubview:newsVC.view];
}

#pragma mark 滚动结束（手势滑动结束）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值，避免最左边往右拉时形变超过1
    
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSLog(@"value--!%lf",value);
    NSUInteger leftIndex = (int)value;
    NSLog(@"leftIndex--!%lu",(unsigned long)leftIndex);
    NSUInteger rightIndex = (int)leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    NSLog(@"scaleRight:%lf   scaleLeft:%lf",scaleRight,scaleLeft);
    LMJTitleLabel *leftLabel = self.smallScollView.subviews[leftIndex];
    leftLabel.scale = scaleLeft;
    // 考虑到最后一个版块，如果右边没有板块，就不在下面赋值scale
    if (rightIndex < self.smallScollView.subviews.count) {
        LMJTitleLabel *labelRight = self.smallScollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)addWeather{
//    LMJWeatherView *weatherView = [LMJWeatherView view];
}



@end
