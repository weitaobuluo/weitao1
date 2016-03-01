//
//  HeadDetailViewController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewModel.h"
#import "HomeDetailModel.h"
#import "AdListModel.h"
@interface HeadDetailViewController : UIViewController
@property (nonatomic,strong)AdListModel *model;
@property (nonatomic,strong)HomeDetailModel *detailModel;
@end
