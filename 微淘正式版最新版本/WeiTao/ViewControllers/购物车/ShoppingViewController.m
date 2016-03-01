//
//  ShoppingViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "ShoppingViewController.h"
#import "DBManager.h"
#import "HomeDetailModel.h"
#import "ManCell.h"
#import "HeadDetailViewController.h"
@interface ShoppingViewController ()

@end

@implementation ShoppingViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataSource!=nil) {
        [self.dataSource removeAllObjects];
    }
    self.dataSource=[[NSMutableArray alloc]init];
    DBManager *manager1=[DBManager defaultDBManager];
    NSArray *array=[manager1 allAppDetailModel];
    [self.dataSource addObjectsFromArray:array];
     [self addAlertView];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"我的收藏";
}
- (void)addAlertView{
    if (self.dataSource.count==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"亲,您好" message:@"您的收藏车为空，请尽快去选购噢" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter{
}
- (void)loadResponseObject:(id)responseObject{
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManCell *cell=[tableView dequeueReusableCellWithIdentifier:@"storecell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ManCell" owner:self options:nil][0];
    }
    cell.shoppingClick=^{
        HomeDetailModel *model=self.dataSource[indexPath.row];
        HeadDetailViewController *vc=[[HeadDetailViewController alloc]init];
        vc.detailModel=model;
        [self.navigationController pushViewController:vc animated:YES];
    };
    HomeDetailModel *model=self.dataSource[indexPath.row];
    [cell loadTitle:model.title withPic:model.category];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DBManager *manager1=[DBManager defaultDBManager];
    HomeDetailModel *model=self.dataSource[indexPath.row];
    [manager1 deleteAppDetailModel:model];
    [self.dataSource removeObject:model];
    [self.tableView reloadData];
}
@end
