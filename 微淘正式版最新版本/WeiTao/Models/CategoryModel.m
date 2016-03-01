//
//  CategoryModel.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
- (void)setValuesWithDictionary:(NSDictionary *)dict{
    _icon=dict[@"icon"];
    _ID=dict[@"id"];
    _name=dict[@"name"];
}

//"en_name" : "Beauty",
//"icon" : "http://7viiaj.com2.z0.glb.qiniucdn.com/newcategory/014.png",
//"id" : "14",
//"name" : "美妆"
@end
