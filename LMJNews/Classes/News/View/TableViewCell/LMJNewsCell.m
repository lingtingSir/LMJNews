//
//  LMJNewsCell.m
//  LMJNews
//
//  Created by lmj on 15/12/30.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJNewsCell.h"
#import <UIImageView+WebCache.h>

@interface LMJNewsCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblReply;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgOther1;
@property (weak, nonatomic) IBOutlet UIImageView *imgOther2;

@end

@implementation LMJNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setT1348647853363:(T1348647853363 *)t1348647853363
{
    _t1348647853363 = t1348647853363;
   
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:_t1348647853363.imgsrc]];
    self.lblTitle.text = self.t1348647853363.title;
    self.lblSubtitle.text = self.t1348647853363.digest;
    
    // 如果回复太多酒改成几点几万
    CGFloat count = self.t1348647853363.replyCount;
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count / 10000];
    } else {
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.lblReply.text = displayCount;
    
    // 多图cell
    if (self.t1348647853363.imgextra.count == 2) {
        [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:self.t1348647853363.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
        [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:self.t1348647853363.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
    }
}

#pragma mark - 类方法返回可重用的id
+ (NSString *)idForRow:(T1348647853363 *)t1348647853363
{
    if (t1348647853363.hasHead && t1348647853363.photosetID) {
        return @"TopImageCell";
    } else if (t1348647853363.hasHead) {
        return @"TopTxtCell";
    } else if (t1348647853363.skipType) {
        return @"BigImageCell";
    } else if (t1348647853363.imgextra) {
        return @"ImagesCell";
    } else {
        return @"NewsCell";
    }
}

#pragma mark - 类方法返回行高
+ (CGFloat)heightForRow:(T1348647853363 *)t1348647853363
{
    if (t1348647853363.hasHead && t1348647853363.photosetID) {
        return  245;
    } else if (t1348647853363.hasHead) {
        return 245;
    } else if (t1348647853363.skipType) {
        return  170;
    } else if (t1348647853363.imgextra) {
        return  130;
    } else {
        return 80;
    }
}


@end
