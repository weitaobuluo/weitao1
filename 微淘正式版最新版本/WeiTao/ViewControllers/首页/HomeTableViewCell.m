//
//  HomeTableViewCell.m
//  WeiTao
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Size.width, kHomeCell_Height+50)];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.alwaysBounceVertical=NO;
        _scrollView.alwaysBounceHorizontal=NO;
         }
    return _scrollView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    self.scrollView.alwaysBounceHorizontal=NO;
    self.scrollView.alwaysBounceVertical=NO;
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:self.scrollView];
}


-(void)setArray:(NSMutableArray *)array{
    _array=array;
    self.scrollView.contentSize=CGSizeMake(kUIScreen_Size.width*(array.count), self.scrollView.frame.size.height);
    
    for (int i=0; i<array.count; i++) {
        [array[i] view].frame=CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:[array[i] view]];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/kUIScreen_Size.width;
    if (self.scrollAtIndex) {
        _scrollAtIndex(index);
    }
}
- (void)setPage:(NSInteger)page{
    self.scrollView.contentOffset=CGPointMake(kUIScreen_Size.width*page,0);
}

@end
