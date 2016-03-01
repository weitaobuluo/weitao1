//
//  HomePicModel.h
//  WeiTao
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "JSONModel.h"

@protocol HomePicModel

@end

@interface HomePicModel : JSONModel
@property (nonatomic,copy)NSString *pic;
@end
