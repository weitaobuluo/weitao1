//
//  DetailViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "DetailViewController.h"
#import "HomeDetailModel.h"
#import "HomeDetailOneCell.h"
#import "HomeDetailCell.h"
#import "HeadDetailViewController.h"
#import "UMSocial.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)addUI{
    CGRect rect=self.tableView.frame;
    rect=CGRectMake(0, 0, kUIScreen_Size.width, kUIScreen_Size.height-109);
    self.tableView.frame=rect;
    [self.view addSubview:self.tableView];
}
- (void)buttonClick:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loadDataWithId:(NSString *)ID{
    NSString *path=[NSString stringWithFormat:kMiaoshu,ID];
    [self loadDataWithPath:path parameter:nil];
}
- (void)loadResponseObject:(id)responseObject{
    NSArray *array=responseObject[@"data"][@"product"];
    NSArray *arr=[HomeDetailModel arrayOfModelsFromDictionaries:array];
    [self.dataSource addObjectsFromArray:arr];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailModel *model=self.dataSource[indexPath.row];
    if (model.pic.count==2) {
        HomeDetailOneCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailTwoCell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"HomeDetailOneCell" owner:self options:nil][0];
        }
        cell.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.9];
        cell.model=model;
        cell.shareClick=^{
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5670c05d67e58e5d4c002ec4"
                                              shareText:@"微淘很精彩"
                                             shareImage:[UIImage imageNamed:@"icon.png"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,
                                            UMShareToRenren,nil]
                                               delegate:nil];
        };
        return cell;
    }
    if (model.pic.count==1) {
        HomeDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailOneCell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"HomeDetailCell" owner:self options:nil][0];
        }
        cell.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.9];
        cell.model=model;
        cell.shareClick=^{
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5670c05d67e58e5d4c002ec4"
                                              shareText:@"微淘很精彩"
                                             shareImage:[UIImage imageNamed:@"icon.png"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,
                                                         UMShareToRenren,nil]
                                               delegate:nil];
        };
        return cell;
    }
    return nil;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailModel *model=self.dataSource[indexPath.row];
    if (model.pic.count==2) {
        return 406;
    }
    if (model.pic.count==1) {
        return 212;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadDetailViewController *head=[[HeadDetailViewController alloc]init];
    head.detailModel=self.dataSource[indexPath.row];
    [self.navigationController pushViewController:head animated:YES];
}
@end
