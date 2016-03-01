//
//  AboutViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    [self addButton];
}
- (void)addButton{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-80)/2, kUIScreen_Size.height-120, 80, 40)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    button.layer.borderWidth=2;
    button.layer.borderColor=[[UIColor whiteColor]CGColor];
    button.backgroundColor=[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
- (void)buttonClick:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addImageView{
    self.view.backgroundColor=[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    UIImage *image=[UIImage imageNamed:@"big"];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-image.size.width)/2,60, image.size.width, image.size.height)];
    imageview.image= image;
    [self.view addSubview:imageview];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-300)/2, CGRectGetMaxY(imageview.frame)+40,300, 80)];
    label.text=@"微淘联盟,淘你喜欢,淘你所爱!";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:label];
}
@end
