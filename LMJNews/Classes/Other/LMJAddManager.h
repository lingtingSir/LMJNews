//
//  LMJAddManager.h
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LMJAddManager : NSObject

+ (BOOL)isShouldDisplayAdd;
+ (UIImage *)getAddImage;
+ (void)loadLatestAddImage;
+ (void)downloadImage:(NSString *)imageUrl;

@end
