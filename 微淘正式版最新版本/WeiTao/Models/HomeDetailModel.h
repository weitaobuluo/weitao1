//
//  HomeDetailModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"
#import "HomePicModel.h"
@interface HomeDetailModel : JSONModel
@property (nonatomic,strong)NSMutableArray<HomePicModel> *pic;
@property (nonatomic,strong)NSString * category;
@property (nonatomic,strong)NSString * desc;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * likes;
@property (nonatomic,strong)NSString * topic_id;
@property (nonatomic,strong)NSString  * comments;
@property (nonatomic,strong)NSString  * price;
@property (nonatomic,strong)NSString  * number;
@property (nonatomic,strong)NSString * url;
@end
