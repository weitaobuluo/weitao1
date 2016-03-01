//
//  HomeRootController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HomeRootController.h"
#import "HomeTableViewCell.h"
#import "HomeCellModel.h"
#import "ManCell.h"
#import "DetailViewController.h"
@interface HomeRootController ()

@end

@implementation HomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;

}
- (void)addUI{
    CGRect rect=self.tableView.frame;
    rect=CGRectMake(0, 0, kUIScreen_Size.width,kUIScreen_Size.height-310);
    self.tableView.frame=rect;
    [self.view addSubview:self.tableView];
}
- (void)loadData{
    [self createDataSource];
    NSString *path=[NSString stringWithFormat:kXiangQing,_ID,_page];
    [self loadDataWithPath:path parameter:nil];
}
- (void)createDataSource{
    
}
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter{
//    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self loadResponseObject:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    [self.manager POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [self loadResponseObject:responseObject];
    } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}
- (void)loadResponseObject:(id)responseObject{
    NSArray * array=responseObject[@"data"][@"topic"];
    NSArray * homeArrs=[HomeCellModel arrayOfModelsFromDictionaries:array];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict=array[i];
        HomeCellModel *model=homeArrs[i];
        model.ID=dict[@"id"];
    }
    [self.dataSource addObjectsFromArray:homeArrs];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManCell *cell=[tableView dequeueReusableCellWithIdentifier:@"manCell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ManCell" owner:self options:nil][0];
    }
    HomeCellModel *model=self.dataSource[indexPath.row];
    cell.model=model;
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kManCell_Height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCellModel *model=self.dataSource[indexPath.row];
    if (_buttonClickAtID) {
       self.buttonClickAtID(model.ID);
    }

}


@end
