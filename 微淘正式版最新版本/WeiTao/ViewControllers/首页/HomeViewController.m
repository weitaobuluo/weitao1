//
//  HomeViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HomeViewController.h"
#import "HeadViewModel.h"
#import "HeadView.h"
#import "HeadDetailViewController.h"
#import "ManViewController.h"
#import "HomeTableViewCell.h"
#import "WomanViewController.h"
#import "FoodViewController.h"
#import "CosmeticViewController.h"
#import "DetailViewController.h"
#import "RESideMenu.h"
#import "ShoppingViewController.h"

#define Button_Tag 20
#define GAP 10
@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *headviewArr;
@property (nonatomic,strong)NSMutableArray *tableViewsArr;
@end

@implementation HomeViewController
{
    ManViewController *_man;
    WomanViewController *_woman;
    FoodViewController * _food;
    CosmeticViewController *_cos;
    NSInteger _scrollPage;
    RESideMenu * _sideMenu;
    QRViewController *_qr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeDetail];
    [self addBarButtonItem];

}
- (void)addBarButtonItem{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setImage:[[UIImage imageNamed:@"btn_nav_option_h4@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(head1Click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
    UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button1 setImage:[[UIImage imageNamed:@"shared_scanbuttom_highlighted@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(head2Click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem=item2;
}
- (void)head2Click:(UIButton *)button{
    
    _qr = [[QRViewController alloc]init];
    _qr.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:_qr];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)initUI:(CGRect)previewFrame
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (error) {
        NSLog(@"你手机不支持二维码扫描!");
        return;
    }
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    self.session = [[AVCaptureSession alloc]init];
    
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code];
    
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.preview.frame = previewFrame;
    
    [self.view.layer addSublayer:self.preview];
    
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    [self.session stopRunning];
    
    [self.preview removeFromSuperlayer];
    
    NSString *val = nil;
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        val = obj.stringValue;
        
        NSLog(@"val = %@",val);
    }
    
    
    
}

- (void)qrCodeComplete:(NSString *)codeString
{
    [_qr dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"codeString = %@",codeString);
}

- (void)qrCodeError:(NSError *)error
{
    
}



- (void)head1Click:(UIButton *)button{
    [UIView animateWithDuration:0.5 animations:^{
        [self performSelector:@selector(presentLeftMenuViewController:) withObject:self];
    }];
}
- (void)changeDetail{
    __weak HomeViewController *weakSelf=self;
    _man.buttonClickAtID=^(NSString * ID){
        DetailViewController *detail=[[DetailViewController alloc]init];
        [detail loadDataWithId:ID];
    [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    _woman.buttonClickAtID=^(NSString * ID){
        DetailViewController *detail=[[DetailViewController alloc]init];
        [detail loadDataWithId:ID];
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    _food.buttonClickAtID=^(NSString * ID){
        DetailViewController *detail=[[DetailViewController alloc]init];
        [detail loadDataWithId:ID];
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    _cos.buttonClickAtID=^(NSString * ID){
        DetailViewController *detail=[[DetailViewController alloc]init];
        [detail loadDataWithId:ID];
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    
}
- (void)loadData{
    [self createDataSource];
    [self loadDataWithPath:kHeadView_Url parameter:nil];
}
- (void)createDataSource{
    _scrollPage=0;
    _man=[[ManViewController alloc]init];
    _woman=[[WomanViewController alloc]init];
    _food=[[FoodViewController alloc]init];
    _cos=[[CosmeticViewController alloc]init];
}
- (void)loadResponseObject:(id)responseObject{
    NSArray *array=responseObject[@"data"][@"list"][0][@"data"];
    NSArray *headview=[HeadViewModel arrayOfModelsFromDictionaries:array];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict=array[i];
        NSString *src=dict[@"src"];
        NSArray *srcArr=[src componentsSeparatedByString:@"?"];
        NSString *srcNow=[srcArr firstObject];
        NSString *url=dict[@"url"];
        NSArray *urlArr=[url componentsSeparatedByString:@"?"];
        NSString *urlNow=[urlArr firstObject];
        HeadViewModel *model=headview[i];
        model.src=srcNow;
        model.url=urlNow;
    }
    [self.headviewArr addObjectsFromArray:headview];
    [self.tableView reloadData];
    [self loadHeadView];

}

- (void)loadHeadView{
    HeadView *view=[[HeadView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, 160)];
    [view loadImageForArray:self.headviewArr];
    view.clickAtIndex=^(NSInteger index){
        HeadDetailViewController *vc=[[HeadDetailViewController alloc]init];
        vc.model=self.headviewArr[index];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView=view;
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    if (cell==nil) {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homecell"];
    }
    NSArray *viewControllers=@[_man,_woman,_cos,_food];
    cell.array=viewControllers;
    cell.scrollAtIndex=^(NSInteger index){
        [self loadScrollAtIndex:index];
    };
    cell.page=_scrollPage;
    return cell;
}
- (void)loadScrollAtIndex:(NSInteger)index{
    UIView *view=(id)[self.view viewWithTag:11];
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect=view.frame;
        rect=CGRectMake(kUIScreen_Size.width/4*index+30, 30, kUIScreen_Size.width/4-50, 2);
        view.frame=rect;
    }];

}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHomeCell_Height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width/4, 40)];
    scrollView.tag=10;
    scrollView.delegate=self;
    scrollView.contentSize=CGSizeMake(kUIScreen_Size.width, 20);
    NSArray *array=@[@"男装",@"女装",@"护肤",@"美食"];
    for (int i=0; i<4; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kUIScreen_Size.width/4*i+7,5, kUIScreen_Size.width/4, 20)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag=Button_Tag+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(30+kUIScreen_Size.width/4*_scrollPage,30, kUIScreen_Size.width/4-50, 2)];
    view.tag=11;
    view.backgroundColor=[UIColor redColor];
    [scrollView addSubview:view];
    return scrollView;
}
- (void)buttonClick:(UIButton *)button{
    NSInteger page=button.tag-Button_Tag;
    UIView *view=(id)[self.view viewWithTag:11];
    [UIView animateWithDuration:0.6 animations:^{
        CGRect rect=view.frame;
        rect=CGRectMake(kUIScreen_Size.width/4*page+30, 30, kUIScreen_Size.width/4-50, 2);
        view.frame=rect;
    }];
    _scrollPage=page;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark - 懒加载
- (NSMutableArray *)headviewArr{
    if (_headviewArr==nil) {
        _headviewArr=[[NSMutableArray alloc]init];
    }
    return _headviewArr;
}

- (NSMutableArray *)tableViewsArr{
    if (_tableViewsArr==nil) {
        _tableViewsArr=[[NSMutableArray alloc]init];
    }
    return _tableViewsArr;
}

@end
