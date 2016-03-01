//
//  PJRootViewController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property (nonatomic,strong)NSMutableArray *dataSource;
- (void)addUI;
- (void)loadData;
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter;
- (void)loadResponseObject:(id)responseObject;
@end
