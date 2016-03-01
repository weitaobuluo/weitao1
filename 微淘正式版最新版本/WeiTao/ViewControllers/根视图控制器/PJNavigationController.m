//
//  PJNavigationController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJNavigationController.h"
#import "AppSetting.h"
@interface PJNavigationController ()

@end

@implementation PJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [AppSetting menuColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange) name:@"changeColor" object:nil];

    self.navigationBar.translucent=NO;

}
- (void)onChange{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationBar.barTintColor = [AppSetting menuColor];
    }];
}

@end
