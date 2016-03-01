//
//  HomeDetailOneCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailModel.h"
@interface HomeDetailOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIButton *store;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (nonatomic,assign)BOOL isClick;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,strong)HomeDetailModel *model;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (nonatomic,copy)void (^shareClick)();

@end
