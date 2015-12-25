//
//  LMJBarButton.m
//  LMJNews
//
//  Created by lmj on 15/12/24.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJBarButton.h"
#import "UIView+Extension.h"



@implementation LMJBarButton

- (void)setHighlighted:(BOOL)highlighted
{
    // 目的就是重写取消高亮显示
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 5;
    self.imageView.width = 25;
    self.imageView.height = 25;
    self.imageView.x = (self.width - self.imageView.width) / 2.0;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width) / 2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    self.titleLabel.font = [UIFont fontWithName:@"HYQIHEI" size:10];
    self.titleLabel.shadowColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}



@end



