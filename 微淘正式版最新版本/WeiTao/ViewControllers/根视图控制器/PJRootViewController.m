//
//  PJRootViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJRootViewController.h"
#import "DetailViewController.h"

@interface PJRootViewController ()

@end

@implementation PJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addUI];
    [self loadData];
}
- (void)addUI{
[self.view addSubview:self.tableView];
}
- (void)loadData{
    [self loadDataWithPath:@"" parameter:nil];
}
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter{
    [self.manager POST:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loadResponseObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadResponseObject:(id)responseObject{
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (AFHTTPRequestOperationManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPRequestOperationManager manager];
//        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}


@end
