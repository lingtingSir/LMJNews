//
//  LMJTabBar.h
//  LMJNews
//
//  Created by lmj on 15/12/23.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LMJTabBarDelegate;
@interface LMJTabBar : UIView

@property (nonatomic,weak) id<LMJTabBarDelegate> delegate;

- (void)addImageView;
- (void)addBarButtonWithNorName:(NSString *)normal andDisName:(NSString *)diselected andTitle:(NSString *)title;

@end

@protocol LMJTabBarDelegate <NSObject>

- (void)ChangeSelIndexFrom:(NSInteger)from to:(NSInteger)to;

@end
