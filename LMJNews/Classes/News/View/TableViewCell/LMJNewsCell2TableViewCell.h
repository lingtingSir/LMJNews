//
//  LMJNewsCell2TableViewCell.h
//  LMJNews
//
//  Created by lmj on 15/12/31.
//  Copyright © 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJNewsModel.h"
@interface LMJNewsCell2TableViewCell : UITableViewCell

@property(nonatomic,strong) T1348647853363 *NewsModel;



/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(T1348647853363 *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(T1348647853363 *)NewsModel;
@end
