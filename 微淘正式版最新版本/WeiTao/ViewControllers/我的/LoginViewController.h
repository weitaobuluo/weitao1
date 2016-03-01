//
//  LoginViewController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineViewController.h"

@protocol LoginViewControllerDelegate <NSObject>
- (void)loadUserName:(NSString *)userName with:(NSString *)url;
@end

@interface LoginViewController : UIViewController
@property (nonatomic,weak)id<LoginViewControllerDelegate>delegate;
@end
