//
//  HomeRootController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJRootViewController.h"

@interface HomeRootController : PJRootViewController
{
    NSString * _ID;
    int _page;
}
@property (nonatomic,copy)void(^buttonClickAtID)(NSString * ID);
- (void)addUI;
- (void)loadData;
- (void)createDataSource;
- (void)loadResponseObject:(id)responseObject;
@end
