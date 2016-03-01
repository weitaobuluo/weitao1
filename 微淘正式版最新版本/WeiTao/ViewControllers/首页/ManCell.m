//
//  ManCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "ManCell.h"

@implementation ManCell

- (void)setModel:(HomeCellModel *)model{
    _model=model;
    [_foreImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    _foreImageView.layer.cornerRadius=10;
    _foreImageView.layer.masksToBounds=YES;
    _title.text=model.title;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.textColor=[UIColor whiteColor];
}
- (void)loadTitle:(NSString *)title withPic:(NSString *)pic{
    [_foreImageView sd_setImageWithURL:[NSURL URLWithString:pic]];
    _foreImageView.layer.cornerRadius=6;
    _foreImageView.layer.masksToBounds=YES;
    _title.text=title;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.textColor=[UIColor whiteColor];
    _button=[[UIButton alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-130,20,90, 20)];
    [_button setBackgroundColor:[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1]];
    _button.layer.cornerRadius=10;
    _button.layer.masksToBounds=YES;
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitle:@"进入购买" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];
}
- (void)buttonClick:(UIButton *)button{
    if (self.shoppingClick) {
        _shoppingClick();
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];

}
@end
