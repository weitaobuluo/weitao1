//
//  CategoryDetailModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@interface CategoryDetailModel : JSONModel
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *pic;
@property (nonatomic,copy)NSString *title;
- (void)setValuesWithDictionary:(NSDictionary *)dict;
@end
