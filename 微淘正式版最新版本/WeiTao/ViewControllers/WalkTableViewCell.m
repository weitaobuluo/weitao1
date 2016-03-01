//
//  WalkTableViewCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "WalkTableViewCell.h"

@implementation WalkTableViewCell

- (void)setModel:(ArtListModel *)model{
    _model=model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.src]];
    _headImageView.layer.cornerRadius=15;
    _headImageView.layer.masksToBounds=YES;
    _name.text=model.name;
    _title.text=model.title;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:model.src]];
    _bigImageView.layer.cornerRadius=10;
    _bigImageView.layer.masksToBounds=YES;
    _info.text=model.intro;
    _info.numberOfLines=0;
    [_see setTitle:model.views_num forState:UIControlStateNormal];
    [_see setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_see setImage:[[UIImage imageNamed:@"login_password_see_icon@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}







@end
