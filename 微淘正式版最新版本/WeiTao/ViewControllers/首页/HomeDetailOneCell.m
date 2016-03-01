//
//  HomeDetailOneCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HomeDetailOneCell.h"
#import "HomePicModel.h"
#import "DBManager.h"

@implementation HomeDetailOneCell

- (void)setModel:(HomeDetailModel *)model{
    _model=model;
    HomePicModel *picOneModel=model.pic[0];
    NSArray *picOneArr=[picOneModel.pic componentsSeparatedByString:@"\\"];
    HomePicModel *picTwoModel=model.pic[1];
    NSArray *picTwoArr=[picTwoModel.pic componentsSeparatedByString:@"\\"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:picOneArr[0]]];
    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:picTwoArr[0]]];
    [_store setImage:[[UIImage imageNamed:@"star2_Gray@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_store setImage:[[UIImage imageNamed:@"star_icon@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_store addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _isClick=NO;
    _title.text=model.title;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.textColor=[UIColor grayColor];
    [_share setImage:[[UIImage imageNamed:@"fx"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    _likes.text=[NSString stringWithFormat:@"%@人收藏",model.likes];
    _likes.textColor=[UIColor whiteColor];
    [self addStore];
}
- (void)shareClick:(UIButton *)button{
    if (self.shareClick) {
        _shareClick();
    }
}
- (void)addStore{
    DBManager *manager=[DBManager defaultDBManager];
    NSArray *array=[manager allAppDetailModel];
    static int i=0;
    for (HomeDetailModel *model in array) {
        if ([_model.title isEqualToString:model.title]==YES) {
            _store.selected=YES;
        }
        i++;
    }
}
- (void)buttonClick:(UIButton *)button{
    if (_isClick==YES) {
        button.selected=NO;
        DBManager *manager=[DBManager defaultDBManager];
        [manager deleteAppDetailModel:_model];
        _isClick=NO;
    }
    else {
        DBManager *manager=[DBManager defaultDBManager];
        [manager saveAppDetailModel:_model];
        button.selected=YES;
        _isClick=YES;
    }
}

@end
