//
//  AdListModel.m
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "AdListModel.h"

@implementation AdListModel
- (void)setValuesWithDictionary:(NSDictionary *)dict{
    NSString *src=dict[@"src"];
    NSArray *srcArr=[src componentsSeparatedByString:@"?"];
    NSString *srcNow=[srcArr firstObject];
    NSString *url=dict[@"url"];
    NSArray *urlArr=[url componentsSeparatedByString:@"?"];
    NSString *urlNow=[urlArr firstObject];
    _src=srcNow;
    _url=urlNow;
}
@end
