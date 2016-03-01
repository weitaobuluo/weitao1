//
//  HomeCellModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@interface HomeCellModel : JSONModel
@property (nonatomic,copy)NSString<Optional> * ID;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * likes;
@property (nonatomic,copy)NSString * pic;
@end
