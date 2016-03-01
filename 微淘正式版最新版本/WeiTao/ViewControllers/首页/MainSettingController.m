//
//  MainSettingController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "MainSettingController.h"
#import "ShoppingViewController.h"
#import "AppSetting.h"
@interface MainSettingController ()

@end

@implementation MainSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackgroundView];
    [self addUI];
}
- (void)addBackgroundView{
    self.navigationController.navigationBarHidden=YES;
    UIImage *image=[UIImage imageNamed:@"Default_miao"];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.image=image;
    [self.view addSubview:imageview];
}
- (void)addUI{
    

    
    //横线
    UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(10, kUIScreen_Size.width*20/89+150, kUIScreen_Size.width*2/3, 0.5)];
    line1.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    //历史记录
    UIImageView *btnImage1=[[UIImageView alloc]initWithFrame:CGRectMake(30, line1.frame.origin.y+10, 40, 40)];
    btnImage1.image=[UIImage imageNamed:@"button_history.png"];
    [self.view addSubview:btnImage1];
    
    UIButton *histBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    histBtn.frame=CGRectMake(btnImage1.frame.origin.x+60, btnImage1.frame.origin.y, kUIScreen_Size.width/4, 40);
    [histBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
    [histBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    histBtn.tag=303;
    histBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    histBtn.layer.borderWidth=1;
    histBtn.layer.cornerRadius=6;
    histBtn.layer.masksToBounds=YES;
    [histBtn addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:histBtn];
    
    
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y+60, kUIScreen_Size.width*2/3, 0.5)];
    line2.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    //收藏
    
    
    UIImageView *btnImage2=[[UIImageView alloc]initWithFrame:CGRectMake(30, line2.frame.origin.y+10, 40, 40)];
    btnImage2.image=[UIImage imageNamed:@"button_dislike@2x.png"];
    [self.view addSubview:btnImage2];
    
    UIButton *collecBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    collecBtn.frame=CGRectMake(btnImage2.frame.origin.x+60, btnImage2.frame.origin.y, kUIScreen_Size.width/4, 40);
    [collecBtn setTitle:@"更换皮肤" forState:UIControlStateNormal];
    [collecBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    collecBtn.tag=304;
    collecBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    collecBtn.layer.borderWidth=1;
    collecBtn.layer.cornerRadius=6;
    collecBtn.layer.masksToBounds=YES;
    [collecBtn addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collecBtn];
    
    
    
    UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(10, line2.frame.origin.y+60, kUIScreen_Size.width*2/3,0.5)];
    line3.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:line3];
    
    
    
    //退出按钮
    self.exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.exitButton.frame=CGRectMake(collecBtn.frame.origin.x, line3.frame.origin.y+40, kUIScreen_Size.width/4, 38);
    [self.exitButton setTitle:@"退 出" forState:UIControlStateNormal];
    [self.exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.exitButton.tag=305;
    self.exitButton.backgroundColor=[UIColor colorWithRed:0.88f green:0.34f blue:0.45f alpha:1.00f];
    self.exitButton.layer.borderColor=[UIColor colorWithRed:0.88f green:0.34f blue:0.45f alpha:1.00f].CGColor;
    self.exitButton.layer.borderWidth=1;
    self.exitButton.layer.cornerRadius=6;
    self.exitButton.layer.masksToBounds=YES;
    [self.exitButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.exitButton];

}
- (void)buttonOnClick:(UIButton *)button{
    if (button.tag==303) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要清理2.6M缓存吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
    }
    if (button.tag==304) {

        int red =249;
        int green  =69;
        int blue =123;
        static int num=0;
        switch (num%4) {
            case 0:
                red =100;
                green  =182;
                blue =251;
                break;
            case 1:
                red =249;
                green  =69;
                blue =123;
                break;
            case 2:
                red =56;
                green  =66;
                blue =26;
                break;
            case 3:
                red =248;
                green  =218;
                blue =68;
                break;
            default:
                break;
        }
        NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
        [u setInteger:red forKey:@"red"];
        [u setInteger:green forKey:@"green"];
        [u setInteger:blue forKey:@"blue"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
        num++;
    }
    if (button.tag==305) {
        exit(0);
    }
}

@end
