//
//  LMJHTTPManager.m
//  LMJNews
//
//  Created by lmj on 15/12/29.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJHTTPManager.h"

@implementation LMJHTTPManager

+ (instancetype)manager
{
    LMJHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    [mgrSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    return mgr;
}

@end
