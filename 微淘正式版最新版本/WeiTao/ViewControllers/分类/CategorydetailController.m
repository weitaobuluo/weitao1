//
//  CategorydetailController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "CategorydetailController.h"
#import "HomeDetailModel.h"
#import "DetailCollectionViewCell.h"
#import "HeadDetailViewController.h"
@interface CategorydetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegate>
{

    NSString *_ID;
    UICollectionView *_collectionView;
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation CategorydetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self addUI];
    [self addNavigationItem];
}
- (void)addNavigationItem{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,80, 30)];
    [button setTitle:@"价格排序" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=item;
}
- (void)buttonClick:(UIButton *)button{
    if (_isAscending==YES) {
    HomeDetailModel *temp=nil;
        for (int i=0;i<self.dataSource.count; i++) {
            for (int j=0; j<self.dataSource.count-i-1; j++) {
            HomeDetailModel *iModel=self.dataSource[j];
            HomeDetailModel *jModel=self.dataSource[j+1];
                if ([iModel.price intValue]<[jModel.price intValue]) {
                    temp=self.dataSource[j];
                    self.dataSource[j]=self.dataSource[j+1];
                    self.dataSource[j+1]=temp;
                }
            }
        }
        _isAscending=NO;
        [_collectionView reloadData];
    }
    else if (_isAscending==NO){
        HomeDetailModel *temp=nil;
        for (int i=0;i<self.dataSource.count; i++) {
            for (int j=0; j<self.dataSource.count-i-1; j++) {
                HomeDetailModel *iModel=self.dataSource[j];
                HomeDetailModel *jModel=self.dataSource[j+1];
                if ([iModel.price intValue]>[jModel.price intValue]) {
                    temp=self.dataSource[j];
                    self.dataSource[j]=self.dataSource[j+1];
                    self.dataSource[j+1]=temp;
                }
            }
        }
        _isAscending=YES;
        [_collectionView reloadData];
    }
}
-(void)addUI{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self.view addSubview:_collectionView];
}

- (void)loadData{
    NSString *path=[NSString stringWithFormat:kMiaoshu,_ID];
    [self loadDataWithPath:path parameter:nil];
}
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter{
    [self.manager POST:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loadResponseObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadResponseObject:(id)responseObject{
    NSArray *array=responseObject[@"data"][@"product"];
    NSArray *arr=[HomeDetailModel arrayOfModelsFromDictionaries:array];
    [self.dataSource addObjectsFromArray:arr];
    [_collectionView reloadData];
}
#pragma mark - UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HeadDetailViewController *head=[[HeadDetailViewController alloc]init];
    head.detailModel=self.dataSource[indexPath.row];
    [self.navigationController pushViewController:head animated:YES];
    
}
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath下的元素大小
    return CGSizeMake(([[UIScreen mainScreen]bounds].size.width-3*10)/2,220);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //元素水平方向最小距离
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 20, 10);
}

#pragma mark - 懒加载
- (void)setModel:(CategoryDetailModel *)model{
    _model=model;
    _ID=model.ID;
}
- (AFHTTPRequestOperationManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPRequestOperationManager manager];
//        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end
