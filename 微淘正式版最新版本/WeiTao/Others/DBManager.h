//
//  DBManager.h
//  WeiTao
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDetailModel.h"
@interface DBManager : NSObject
//获取数据库的管理对象
+ (id)defaultDBManager;
//增
- (void)saveAppDetailModel:(HomeDetailModel *)model;
//查
- (NSArray *)allAppDetailModel;
//删
- (void)deleteAppDetailModel:(HomeDetailModel *)model;
@end
