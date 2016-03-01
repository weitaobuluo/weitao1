//
//  LeadViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "LeadViewController.h"
#import "AppDelegate.h"
#import "PJHomeTabBarController.h"
#import "RESideMenu.h"
#import "LeadViewController.h"
#import "MainSettingController.h"
@interface LeadViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
    [self addImageView];
}
- (void)addImageView{
//    NSArray *pic=@[@"8",@"7"];
//    for (int i=0; i<2; i++) {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, kUIScreen_Size.height)];
        UIImage *image=[UIImage imageNamed:@"4.0_pg3@2x"];
        imageview.image=image;
        imageview.userInteractionEnabled=YES;
//        if (i==1) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-80)/2, kUIScreen_Size.height-80, 80, 40)];
            [button setTitle:@"进入微淘" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.cornerRadius=5;
            button.layer.masksToBounds=YES;
            button.layer.borderColor=[[UIColor grayColor]CGColor];
            button.layer.borderWidth=2;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageview addSubview:button];
//        }
        [self.scrollView addSubview:imageview];
//    }
}
- (void)buttonClick:(UIButton *)button{
    PJHomeTabBarController *tabBar=[[PJHomeTabBarController alloc]init];
    MainSettingController *set=[[MainSettingController alloc]init];
    RESideMenu *menu=[[RESideMenu alloc]initWithContentViewController:tabBar leftMenuViewController:set rightMenuViewController:nil];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:@"1" forKey:@"FirstLogin"];
    self.view.window.rootViewController=menu;

}
- (void)addScrollView{
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize=CGSizeMake(kUIScreen_Size.width*2, kUIScreen_Size.height);
    self.scrollView.delegate=self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    [self.view addSubview:self.scrollView];
}
@end
