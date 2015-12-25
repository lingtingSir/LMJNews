//
//  LMJNetworkTools.h
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LMJNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
