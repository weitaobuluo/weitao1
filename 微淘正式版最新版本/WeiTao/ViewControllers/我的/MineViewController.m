//
//  MineViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "MineViewController.h"
#import "User.h"
#import "LoginViewController.h"
#import "ShoppingViewController.h"
#import "AboutViewController.h"

#define KImageOriginHeight 250
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate>

@end

@implementation MineViewController
{
    UITableView * _tableview;
    UIImageView * _imageView;
    UIButton * _button;
    UILabel * _label;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self addHeadView];
}
- (void)loadData{
  self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, kUIScreen_Size.height-49-64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor colorWithRed:252/255.0 green:242/255.0 blue:228/255.0 alpha:1];
    [self.view addSubview:_tableview];
    //不让他显示空的黑条
    _tableview.tableFooterView=[[UIView alloc]init];
    
    //设置tableView 开始的地方
    _tableview.contentInset=UIEdgeInsetsMake(KImageOriginHeight, 0, 0, 0);
    NSArray *array=@[@[@{@"title":@"我的收藏",@"pic":@"homepage_liveact_disabled@2x"}],@[@{@"title":@"清理缓存",@"pic":@"homepage_map_disabled@2x"}],@[@{@"title":@"关于我们",@"pic":@"homepage_details_disabled@2x"}],@[@"退出登陆"]];
    [self.dataSource addObjectsFromArray:array];
    [_tableview reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section==0) {
        cell.textLabel.text=self.dataSource[0][0][@"title"];
        cell.imageView.image=[UIImage imageNamed:self.dataSource[0][0][@"pic"]];
    }
    if (indexPath.section==1) {
        cell.textLabel.text=self.dataSource[1][0][@"title"];
        cell.imageView.image=[UIImage imageNamed:self.dataSource[1][0][@"pic"]];
    }
    if (indexPath.section==2) {
        cell.textLabel.text=self.dataSource[2][0][@"title"];
        cell.imageView.image=[UIImage imageNamed:self.dataSource[2][0][@"pic"]];
    }
    if (indexPath.section==3) {
        cell.textLabel.text=self.dataSource[3][0];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, 10)];
    view.backgroundColor=[UIColor colorWithRed:252/255.0 green:242/255.0 blue:228/255.0 alpha:1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (void)addHeadView{
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headview"]];
    _imageView.userInteractionEnabled=YES;
    _imageView.frame=CGRectMake(0, -KImageOriginHeight, kUIScreen_Size.width, KImageOriginHeight);
    _button=[[UIButton alloc]initWithFrame:CGRectMake((_imageView.frame.size.width-50)/2, (_imageView.frame.size.height-50)/2-20, 50, 50)];
    _button.layer.cornerRadius = 25;
    _button.layer.masksToBounds = YES;
    [_button setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_button];
    _label = [[UILabel alloc]init];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.frame = CGRectMake(0, CGRectGetMaxY(_button.frame)+5, self.view.frame.size.width, 20);
    _label.text = @"--请登录--";
    [_imageView addSubview:_label];
    [_tableview addSubview:_imageView];
}
- (void)headClick:(UIButton *)button{
    LoginViewController *log=[[LoginViewController alloc]init];
    log.delegate=self;
    [self.navigationController pushViewController:log animated:YES];
}
- (void)loadUserName:(NSString *)userName with:(NSString *)url{
    _label.text=userName;
    [_button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}
- (NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ShoppingViewController *shop=[[ShoppingViewController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
    if (indexPath.section==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要清理2.6M缓存吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
    }
    if (indexPath.section==2) {
        AboutViewController *about=[[AboutViewController alloc]init];
        [self presentViewController:about animated:YES completion:nil];
    }
    if (indexPath.section==3){
        exit(0);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理原理
    //通过获取滚动视图的偏移量来改变图片的大小
    //获取滚动视图偏移量的X值和Y值
    CGFloat yOffSet=scrollView.contentOffset.y;
    CGFloat xOffSet=(KImageOriginHeight +yOffSet)/2;
    //关键步骤
    if (yOffSet<-KImageOriginHeight) {
        //改变图片imageview的frame值
        CGRect rect=_imageView.frame;
        //改变纵坐标
        rect.origin.y=yOffSet;
        //改变高度
        rect.size.height=-yOffSet;
        //fabs(xOffSet) 绝对值   改变宽度
        rect.size.width=self.view.frame.size.width+fabs(xOffSet)*2;
        //再将改变后的位置 赋给imageview
        _imageView.frame=rect;
        
    }
}

@end
