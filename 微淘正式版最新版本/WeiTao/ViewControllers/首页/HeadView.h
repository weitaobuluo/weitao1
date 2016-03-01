//
//  HeadView.h
//  WeiTao
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
-(void)loadImageForArray:(NSArray*)imageArr;
@property (nonatomic,copy)void (^clickAtIndex)(NSInteger index);
@end
