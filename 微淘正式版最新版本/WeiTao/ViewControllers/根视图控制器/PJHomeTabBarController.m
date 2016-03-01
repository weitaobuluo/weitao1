//
//  PJHomeTabBarController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJHomeTabBarController.h"
#import "PJNavigationController.h"
#import "MineViewController.h"
#import "CategoryViewController.h"
#import "ShoppingViewController.h"
#import "WalkViewController.h"
#import "HomeViewController.h"
#import "AppSetting.h"
@interface PJHomeTabBarController ()
@property (nonatomic,strong)NSMutableArray * viewcontrollers;
@end

@implementation PJHomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子视图
    [self addSubViews];
    [self setBackGroundColor];
    
}
- (void)setBackGroundColor{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, 49)];
    backView.tag=100;
    backView.backgroundColor = [AppSetting menuColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange) name:@"changeColor" object:nil];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
}
- (void)onChange{
    UIView *backview=[self.view viewWithTag:100];
    [UIView animateWithDuration:0.5 animations:^{
        backview.backgroundColor = [AppSetting menuColor];
    }];
}

- (NSMutableArray *)viewcontrollers{
    if (_viewcontrollers==nil) {
        _viewcontrollers=[[NSMutableArray alloc]init];
    }
    return _viewcontrollers;
}
- (void)addSubViews{
    NSArray * controllers=@[@"HomeViewController",@"CategoryViewController",@"WalkViewController",@"MineViewController"];
    NSArray *names=@[@"首页",@"分类",@"逛",@"我的微淘"];
    NSArray *pictures=@[@"tab_bar_home_icon",@"goods_xd_icon@2x",@"tab_bar_around_icon",@"tab_bar_my_icon"];
    for (int i=0; i<controllers.count;i++ ) {
        Class class=NSClassFromString(controllers[i]);
        UIViewController *vc=[[class alloc]init];
        PJNavigationController *nav=[[PJNavigationController alloc]initWithRootViewController:vc];
        vc.title=names[i];
        UITabBarItem *item=[[UITabBarItem alloc]initWithTitle:names[i] image:[[UIImage imageNamed:pictures[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:nil];
        vc.tabBarItem=item;
        [self.viewcontrollers addObject:nav];
    }
    self.viewControllers=self.viewcontrollers;
}


@end
