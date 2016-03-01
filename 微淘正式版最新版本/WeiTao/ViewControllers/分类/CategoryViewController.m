//
//  CategoryViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryModel.h"
#import "CategoryDetailModel.h"
#import "CategoryOneCell.h"
#import "CategorydetailController.h"
@interface CategoryViewController ()
@property (nonatomic,strong)UITableView *tableViewTwo;
@end

@implementation CategoryViewController
{
   
    NSMutableArray * _dataSourceTwo;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isRefresh=NO;
    self.tableView.showsVerticalScrollIndicator=YES;
    [self addTableView];
    [self addGesture];
    [self addRefresh];
}
- (void)addRefresh{
    __weak CategoryViewController *weakSelf=self;
    [_tableViewTwo addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        _page=0;
        _isRefresh=NO;
        NSString *path=[NSString stringWithFormat:kXiangQing,weakSelf.index,weakSelf.page];
        [weakSelf loadDataWithPathTwo:path parameter:nil];
    }];
    [_tableViewTwo addRefreshFooterViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        _isRefresh=YES;
        weakSelf.page++;
        NSString *path=[NSString stringWithFormat:kXiangQing,weakSelf.index,weakSelf.page];
        [weakSelf loadDataWithPathTwo:path parameter:nil];
    }];
}
- (void)addGesture{
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipRight:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipRight];
}
- (void)swipRight:(UISwipeGestureRecognizer *)swipeRight{
    [UIView animateWithDuration:1 animations:^{
        CGRect rect=self.tableViewTwo.frame;
        rect=CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        self.tableViewTwo.frame=rect;
    }];
}
- (void)loadData{
    [self loadDataWithPath:kFenlei parameter:nil];
       }
- (void)loadDataTwo{
    _page=0;
    NSString *path=[NSString stringWithFormat:kXiangQing,_index,_page];
    [self loadDataWithPathTwo:path parameter:nil];
}
- (void)loadDataWithPathTwo:(NSString *)path parameter:(NSDictionary *)parameter{
    [self.manager POST:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loadResponseObjectTwo:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadResponseObjectTwo:(id)responseObject{
    if (_isRefresh==NO) {
        if (_dataSourceTwo!=nil) {
            [_dataSourceTwo removeAllObjects];
        }
        _dataSourceTwo=[[NSMutableArray alloc]init];
    }
    NSArray *array=responseObject[@"data"][@"topic"];
    NSMutableArray *mulArr=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        CategoryDetailModel *model=[[CategoryDetailModel alloc]init];
        [model setValuesWithDictionary:dict];
        [mulArr addObject:model];
    }
    [_dataSourceTwo addObjectsFromArray:mulArr];
    [self.tableViewTwo reloadData];
    [self.tableViewTwo headerEndRefreshingWithResult:JHRefreshResultSuccess];
    [self.tableViewTwo footerEndRefreshing];
}

- (void)loadResponseObject:(id)responseObject{
    NSArray *array=[responseObject objectForKey:@"data"];
    NSMutableArray *mulArr=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        CategoryModel *model=[[CategoryModel alloc]init];
        [model setValuesWithDictionary:dict];
        [mulArr addObject:model];
    }
    [self.dataSource addObjectsFromArray:mulArr];
    [self.tableView reloadData];
}
- (void)addTableView{
    [self.view addSubview:self.tableViewTwo];
    CGRect rect=self.tableView.frame;
    rect=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-113);
    self.tableView.frame=rect;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableView]) {
        return self.dataSource.count;
    }
    if ([tableView isEqual:self.tableViewTwo]) {
        return _dataSourceTwo.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"categorycell"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categorycell"];
        }
        CategoryModel *model=self.dataSource[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        cell.textLabel.text=model.name;
        return cell;
    }
    if ([tableView isEqual:self.tableViewTwo]) {
        CategoryOneCell *cell=[tableView dequeueReusableCellWithIdentifier:@"categoryTwo"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"CategoryOneCell" owner:self options:nil][0];
        }
        CategoryDetailModel *model=_dataSourceTwo[indexPath.row];
        cell.model=model;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        return 44;
    }
    else if ([tableView isEqual:self.tableViewTwo]){
        return 87;
    }
    return 1;
}
- (UITableView *)tableViewTwo{
    if (_tableViewTwo==nil) {
        _tableViewTwo=[[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableViewTwo.showsVerticalScrollIndicator=NO;
        _tableViewTwo.delegate=self;
        _tableViewTwo.dataSource=self;
    }
    return _tableViewTwo;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        [UIView animateWithDuration:1 animations:^{
            CGRect rect=self.tableViewTwo.frame;
            rect=CGRectMake(130, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
            self.tableViewTwo.frame=rect;
            CategoryModel *model=self.dataSource[indexPath.row];
            _index=model.ID;
            _isRefresh=NO;
            [self loadDataTwo];
        }];
    }
    if ([tableView isEqual:self.tableViewTwo]) {
        CategorydetailController *detail=[[CategorydetailController alloc]init];
        CategoryDetailModel *model=_dataSourceTwo[indexPath.row];
        detail.model=model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
