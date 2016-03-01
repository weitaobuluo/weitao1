//
//  ArtListModel.m
//  WeiTao
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "ArtListModel.h"

@implementation ArtListModel
- (void)setValuesWithDictionary:(NSDictionary *)dict{
    _title=dict[@"title"];
    NSString *url=dict[@"url"];
    NSArray *urlArr=[url componentsSeparatedByString:@"&"];
    NSString *urlNow=[urlArr firstObject];
    _url=urlNow;
    _category_name=dict[@"category_name"];
    _intro=dict[@"intro"];
    _name=dict[@"author"][@"name"];
    _views_num=dict[@"views_num"];
    NSString *avatar=dict[@"author"][@"avatar"];
    NSArray *avatarArr=[avatar componentsSeparatedByString:@"?"];
    _avatar=[avatarArr firstObject];
    NSString *src=dict[@"src"];
    NSArray *srcArr=[src componentsSeparatedByString:@"?"];
    NSString *srcNow=[srcArr firstObject];
    _src=srcNow;
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
