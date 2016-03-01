//
//  DetailCollectionViewCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "HomePicModel.h"
@implementation DetailCollectionViewCell
{   UILabel *_label;
    UIImageView * _photoImageView;
    UILabel * _price;
    UILabel * _store;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}
- (void)addUI{
    _photoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-40)];
    _photoImageView.layer.cornerRadius=15;
    _photoImageView.layer.masksToBounds=YES;
    _photoImageView.layer.borderWidth=2;
    _photoImageView.layer.borderColor=[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1].CGColor;
    [self.contentView addSubview:_photoImageView];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoImageView.frame)+5, self.contentView.bounds.size.width,10)];
    [self.contentView addSubview:_label];
    _price=[[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(_label.frame)+5,80, 10)];
    [self.contentView addSubview:_price];
    _store=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_price.frame)-20, CGRectGetMaxY(_label.frame)+5,80, 10)];
    [self.contentView addSubview:_store];
    
}


- (void)setModel:(HomeDetailModel *)model{
    _model=model;
    HomePicModel *homemodel=_model.pic[0];
    NSArray *array=[homemodel.pic componentsSeparatedByString:@"\\"];
    NSString *path=[array firstObject];
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:path]];
    _label.text=model.title;
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:14];
    _price.text=[NSString stringWithFormat:@"￥:%@元",model.price];
    _price.textColor=[UIColor redColor];
    _price.textAlignment=NSTextAlignmentLeft;
    _price.font=[UIFont systemFontOfSize:14];
    _store.text=[NSString stringWithFormat:@"收藏:%@",model.likes];
    _store.font=[UIFont systemFontOfSize:14];
    _store.textAlignment=NSTextAlignmentRight;
}





@end
