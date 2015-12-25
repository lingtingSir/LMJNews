//
//  LMJNetworkTools.m
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJNetworkTools.h"

@implementation LMJNetworkTools

+ (instancetype)sharedNetworkTools
{
    static LMJNetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    });
    return instance;
}

+ (instancetype)sharedNetworkToolsWithoutBaseUrl
{
    static LMJNetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@""];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
