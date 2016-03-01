//
//  ManCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCellModel.h"
@interface ManCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foreImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,strong)HomeCellModel *model;
- (void)loadTitle:(NSString *)title withPic:(NSString *)pic;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,copy)void (^shoppingClick)();
@end
