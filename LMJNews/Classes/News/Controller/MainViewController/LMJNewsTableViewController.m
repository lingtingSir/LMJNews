//
//  LMJNewsTableViewController.m
//  LMJNews
//
//  Created by lmj on 15/12/27.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "LMJNewsTableViewController.h"
#import "LMJNewsCell.h"
#import "LMJNetworkTools.h"
#import "LMJNewsModel.h"
#import "LMJNewsCell2TableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LMJNewsTableViewController ()

@property (nonatomic,strong) NSMutableArray *arrayList;
@property (nonatomic,assign) BOOL update;

@end

@implementation LMJNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor clearColor];
    // 设置回调（一旦进入下拉刷新刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    // 设置回调（一旦进入上拉刷新刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.update = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"LMJAdvertisementKey" object:nil];

   
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)welcome
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
   
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"update"]) {
        return;
    }
    if (self.update == YES) {
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

#pragma mark -－ 刷新数据
#pragma mark 下拉刷新
- (void)loadData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:allUrlstring];

}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString  stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count % 10)];
    [self loadDataForType:2 withURL:allUrlstring];
}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    [[LMJNetworkTools sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"LMJNewsTableViewController--!%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *tempArray = responseObject[key];
//        NSLog(@"tempArray--%@",tempArray);
        NSMutableArray *arrayM = [T1348647853363 objectArrayWithKeyValuesArray:tempArray];
//        NSLog(@"arrayM--%@",arrayM[0][@"title"]);
//        for (T1348647853363 *t1348647853363 in arrayM) {
//            NSLog(@"T1348647853363---%@",t1348647853363.title);
//        }
        if (type == 1) {
            self.arrayList = arrayM;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        } else if (type == 2) {
            [self.arrayList addObjectsFromArray:arrayM];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"LoadDataForType,error:%@",error);
    }];
    
}


#pragma mark - /************************* tbv数据源方法 ***************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayList.count;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    T1348647853363 *t1348647853363 = self.arrayList[indexPath.row];
    
    NSString *ID = [LMJNewsCell idForRow:t1348647853363];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        ID = @"NewsCell";
    }
    
    LMJNewsCell *cell =  [tableView  dequeueReusableCellWithIdentifier:ID];
    
    cell.t1348647853363 = t1348647853363;
//    [cell CellWithModel:newsModel];
    
    return cell;
    
}
#pragma mark - /************************* tbv代理方法 ***************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    T1348647853363 *t1348647853363 = self.arrayList[indexPath.row];
    
    CGFloat rowHeight = [LMJNewsCell heightForRow:t1348647853363];
    
    if ((indexPath.row % 20 == 0)&&(indexPath.row != 0)) {
        rowHeight = 80;
    }
    
    return rowHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
