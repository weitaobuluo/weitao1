//
//  CategoryOneCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryDetailModel;
@interface CategoryOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,strong)CategoryDetailModel *model;

@end
