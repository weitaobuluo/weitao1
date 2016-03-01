//
//  WalkRootController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdListModel.h"
#import "ArtListModel.h"
@interface WalkRootController : UITableViewController
@property (nonatomic,copy)void(^walkClick)(ArtListModel *model);
@property (nonatomic,strong)NSMutableArray *adListArr;
@property (nonatomic,strong)NSMutableArray *artListArr;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;
- (void)loadData;
- (void)loadDataWithPath:(NSString *)path parameter:(NSDictionary *)parameter;
- (void)createHeadView;
@property (nonatomic,copy)void(^myBlock)();
@end
