//
//  CategoryViewController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJRootViewController.h"

@interface CategoryViewController : PJRootViewController
@property (nonatomic,assign)BOOL isRefresh;
@property (nonatomic,assign)int page;
@property (nonatomic,copy) NSString * index;
@end
