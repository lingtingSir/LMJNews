//
//  LMJNewsModel.h
//  LMJNews
//
//  Created by lmj on 15/12/27.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class T1348647853363,Ads,Imgextra;
@interface LMJNewsModel : NSObject

@property (nonatomic, strong) NSArray *T1348647853363;

@end
@interface T1348647853363 : NSObject

@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *imgextra;

@property (nonatomic, copy) NSString *photosetID;

@property (nonatomic, assign) NSInteger hasHead;

@property (nonatomic, assign) NSInteger hasImg;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, copy) NSString *template;

@property (nonatomic, copy) NSString *skipType;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, assign) BOOL hasCover;

@property (nonatomic, assign) NSInteger hasAD;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, assign) BOOL hasIcon;

@property (nonatomic, strong) NSArray *ads;

@property (nonatomic, copy) NSString *ename;

@property (nonatomic, copy) NSString *skipID;

@property (nonatomic, assign) NSInteger order;

@property (nonatomic, copy) NSString *digest;

@end

@interface Ads : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *imgsrc;

@end

@interface Imgextra : NSObject

@property (nonatomic, copy) NSString *imgsrc;

@end

