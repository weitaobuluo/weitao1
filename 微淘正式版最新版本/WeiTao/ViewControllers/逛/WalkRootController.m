//
//  WalkRootController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "WalkRootController.h"
#import "HeadView.h"
#import "HeadDetailViewController.h"
#import "WalkTableViewCell.h"
#import "UMSocial.h"
@interface WalkRootController ()

@end

@implementation WalkRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.alwaysBounceVertical=NO;
    self.tableView.alwaysBounceHorizontal=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
//    [self changeTableViewFrame];
}
//- (void)changeTableViewFrame{
//    CGRect rect=self.tableView.frame;
//    rect=CGRectMake(0, 0, kUIScreen_Size.width, kUIScreen_Size.height-114);
//    self.tableView.frame=rect;
//}
- (void)createHeadView{
    HeadView *view=[[HeadView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, 160)];
    [view loadImageForArray:self.adListArr];
//    view.clickAtIndex=^(NSInteger index){
//        HeadDetailViewController *vc=[[HeadDetailViewController alloc]init];
//        vc.model=self.adListArr[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    };
    self.tableView.tableHeaderView=view;
}
- (void)loadData{

    [self loadDataWithPath:kWalkNew parameter:nil];
}
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter{
    [self.manager GET:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loadResponseObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   
}
- (void)loadResponseObject:(id)responseObject{
        NSArray *adlist=responseObject[@"data"][@"list"][@"adlist"];
    NSArray *artListarr=responseObject[@"data"][@"list"][@"artList"];
        for (NSDictionary *dict in adlist) {
            AdListModel *model=[[AdListModel alloc]init];
            [model setValuesWithDictionary:dict];
            [self.adListArr addObject:model];
        }
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in artListarr) {
        ArtListModel *model=[[ArtListModel alloc]init];
        [model setValuesWithDictionary:dict];
        [array addObject:model];
    }
    [self.artListArr addObjectsFromArray:array];
    [self.tableView reloadData];
    [self createHeadView];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 273;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.artListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalkTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"walkcell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"WalkTableViewCell" owner:self  options:nil][0];
    }

    ArtListModel *model=self.artListArr[indexPath.row];
    cell.model=model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArtListModel *model=self.artListArr[indexPath.row];
    if (self.walkClick) {
        _walkClick(model);
    }
}
#pragma mark - 懒加载
- (AFHTTPRequestOperationManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}

- (NSMutableArray *)adListArr
{
    if (_adListArr==nil) {
        _adListArr=[[NSMutableArray alloc]init];
    }
    return _adListArr;
}
- (NSMutableArray *)artListArr
{
    if (_artListArr==nil) {
        _artListArr=[[NSMutableArray alloc]init];
    }
    return _artListArr;
}
@end
