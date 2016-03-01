//
//  HomeDetailCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePicModel.h"
#import "HomeDetailModel.h"
@interface HomeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIButton *store;
@property (weak, nonatomic) IBOutlet UIImageView *bgimageview;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,assign)BOOL isClick;
@property (nonatomic,strong)HomeDetailModel *model;
@property (nonatomic,copy)void (^shareClick)();
@end
