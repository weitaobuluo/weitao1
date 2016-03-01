//
//  CategoryModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@interface CategoryModel : JSONModel
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *ID;
- (void)setValuesWithDictionary:(NSDictionary *)dict;
@end
