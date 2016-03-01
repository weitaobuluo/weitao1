//
//  ArtListModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@interface ArtListModel : JSONModel
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *category_name;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *views_num;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *src;
- (void)setValuesWithDictionary:(NSDictionary *)dict;
@end
