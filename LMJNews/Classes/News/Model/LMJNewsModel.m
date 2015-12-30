//
//  LMJNewsModel.m
//  LMJNews
//
//  Created by lmj on 15/12/27.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJNewsModel.h"

@implementation LMJNewsModel


+ (NSDictionary *)objectClassInArray{
    return @{@"T1348647853363" : [T1348647853363 class]};
}
@end
@implementation T1348647853363

+ (NSDictionary *)objectClassInArray{
    return @{@"ads" : [Ads class], @"imgextra" : [Imgextra class]};
}

@end


@implementation Ads

@end


@implementation Imgextra

@end


