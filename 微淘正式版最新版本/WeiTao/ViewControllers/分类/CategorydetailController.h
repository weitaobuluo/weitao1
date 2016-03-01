//
//  CategorydetailController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDetailModel.h"
@interface CategorydetailController : UIViewController
@property (nonatomic,strong)CategoryDetailModel *model;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property (nonatomic,assign)BOOL isAscending;
@end
