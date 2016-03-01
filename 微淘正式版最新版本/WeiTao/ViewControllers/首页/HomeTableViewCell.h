//
//  HomeTableViewCell.h
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,copy)void(^scrollAtIndex)(NSInteger index);
@property (nonatomic,assign)NSInteger page;
@end
