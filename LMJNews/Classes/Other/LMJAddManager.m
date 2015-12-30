//
//  LMJAddManager.m
//  LMJNews
//
//  Created by lmj on 15/12/25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJAddManager.h"
#import "LMJNetworkTools.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/addcurrent.png"])
#define kCachedNewImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/addnew.png"])
@implementation LMJAddManager

+ (BOOL)isShouldDisplayAdd
{
    NSLog(@"NSSearchPathForDirectoriesInDomains----%@",NSHomeDirectory());
    return ([[NSFileManager defaultManager] fileExistsAtPath:kCachedCurrentImage isDirectory:NO] || [[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NO]);
}

+ (UIImage *)getAddImage
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NO]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager] moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+ (void)downloadImage:(NSString *)imageUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }
    }];
    [task resume];
}

+ (void)loadLatestAddImage
{
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSLog(@"now---%ld",(long)now);
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    [[[LMJNetworkTools sharedNetworkToolsWithoutBaseUrl] GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSArray *addArray = [responseObject valueForKey:@"ads"];
        NSString *imgUrl = addArray[0][@"res_url"][0];
        NSLog(@"imgUrl--%@",imgUrl);
        NSString *imgUrl2 = nil;
        if (addArray.count > 1) {
            imgUrl2 = addArray[1][@"res_url"][0];
        }
        
        BOOL one = [[NSUserDefaults standardUserDefaults] boolForKey:@"one"];
        if (imgUrl2.length > 0) {
            if (one) {
                [self downloadImage:imgUrl];
              
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            } else {
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            }
        } else {
            [self downloadImage:imgUrl];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@",error);
    }] resume];
}

@end
