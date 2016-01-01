//
//  LMJWeatherModel.h
//  LMJNews
//
//  Created by lmj on 15/12/27.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pm2D5,LMJWeatherModel;
@interface LMJWeatherModel : NSObject

@property (nonatomic, assign) NSInteger rt_temperature;

@property (nonatomic, strong) Pm2D5 *pm2d5;

@property (nonatomic, strong) NSArray *detailArray;

@property (nonatomic, copy) NSString *dt;

@end
@interface Pm2D5 : NSObject

@property (nonatomic, copy) NSString *nbg1;

@property (nonatomic, copy) NSString *aqi;

@property (nonatomic, copy) NSString *nbg2;

@property (nonatomic, copy) NSString *pm2_5;

@end

@interface LMJWeatherDetailModel : NSObject

@property (nonatomic, copy) NSString *temperature;

@property (nonatomic, copy) NSString *wind;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *nongli;

@property (nonatomic, copy) NSString *climate;

@property (nonatomic, copy) NSString *date;

@end

