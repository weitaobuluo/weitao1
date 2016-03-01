//
//  CategoryDetailModel.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "CategoryDetailModel.h"

@implementation CategoryDetailModel
- (void)setValuesWithDictionary:(NSDictionary *)dict{
    _ID=dict[@"id"];
    _title=dict[@"title"];
    _pic=dict[@"pic"];
}
@end
