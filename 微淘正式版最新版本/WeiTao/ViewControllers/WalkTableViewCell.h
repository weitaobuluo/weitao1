//
//  WalkTableViewCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtListModel.h"
@interface WalkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *info;


@property (weak, nonatomic) IBOutlet UIButton *see;
@property (nonatomic,strong)ArtListModel *model;



@end
