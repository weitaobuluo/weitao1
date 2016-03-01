//
//  CategoryOneCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "CategoryOneCell.h"
#import "CategoryDetailModel.h"
@implementation CategoryOneCell

- (void)setModel:(CategoryDetailModel *)model{
    _model=model;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    _bgImageView.layer.cornerRadius=10;
    _bgImageView.layer.masksToBounds=YES;
    _bgImageView.layer.borderWidth=2;
    _bgImageView.layer.borderColor=[[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1]CGColor];
    _title.text=model.title;
}

@end
