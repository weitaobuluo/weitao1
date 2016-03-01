//
//  AdListModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@interface AdListModel : JSONModel
@property (nonatomic,copy)NSString *src;
@property (nonatomic,copy)NSString *url;
- (void)setValuesWithDictionary:(NSDictionary *)dict;
@end
