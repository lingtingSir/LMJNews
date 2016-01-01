//
//  LMJWeatherView.h
//  LMJNews
//
//  Created by lmj on 15/12/27.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMJWeatherModel;
@interface LMJWeatherView : UIView
@property (nonatomic,strong) LMJWeatherModel *weatherModel;


+ (instancetype)view;
- (void)addAnimate;

@end
