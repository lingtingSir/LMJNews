//
//  LMJTabBar.m
//  LMJNews
//
//  Created by lmj on 15/12/23.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJTabBar.h"
#import "LMJBarButton.h"
#import "UIView+Extension.h"

@interface LMJTabBar ()

@property (nonatomic,strong) LMJBarButton *selButton;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation LMJTabBar

- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@""];
    self.imgView = imgView;
    [self addSubview:imgView];
}

#pragma mark － 通过传入数据赋值图片
- (void)addBarButtonWithNorName:(NSString *)normal andDisName:(NSString *)diselected andTitle:(NSString *)title
{
    LMJBarButton *btn = [[LMJBarButton alloc] init];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:diselected] forState:UIControlStateDisabled];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:183/255.0 green:183/255.0 blue:183/255.0 alpha:1] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    // 让第一个按钮默认为选中状态
    if (self.subviews.count == 2) {
//        btn.tag = 1;
        [self btnClick:btn];
    }
}


#pragma mark - 动态加载设置frame值
- (void)layoutSubviews
{
    UIImageView *imgView = self.subviews[0];
    imgView.frame = self.bounds;
    
    for (int i = 1; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 5;
        CGFloat btnH = 49;
        CGFloat btnX = (i - 0) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.tag = i - 1;
    }
}

- (void)btnClick:(LMJBarButton *)btn
{
    // 设置响应代理，实现页面跳转
    if ([self.delegate respondsToSelector:@selector(ChangeSelIndexFrom:to:)]) {
        [self.delegate ChangeSelIndexFrom:_selButton.tag to:btn.tag];
    }
    
    // 设置按钮显示状态，并切换选中按钮
    _selButton.enabled = YES;
    _selButton = btn;
    btn.enabled = NO;
}

@end
