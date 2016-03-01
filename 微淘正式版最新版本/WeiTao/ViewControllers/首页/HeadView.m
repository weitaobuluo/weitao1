//
//  HeadView.m
//  WeiTao
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HeadView.h"
#import "HeadViewModel.h"
#import "AdListModel.h"
@interface HeadView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,strong) NSMutableArray * dataSource;

@end
@implementation HeadView



#pragma makr --- 懒加载
-(UIScrollView*)scrollView{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _scrollView;
}
-(UIPageControl*)pageControl{
    if (_pageControl==nil) {
        _pageControl =[[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width-120, self.frame.size.height-24, 120, 24)];
        [_pageControl addTarget:self action:@selector(pageGo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageControl;
}
-(void)pageGo:(UIPageControl*)page{
    NSInteger index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    
    if (index==0) {
        index = self.dataSource.count;
    }else if (index==self.dataSource.count+1){
        index = 1;
    }else{
        index++;
    }
    self.pageControl.currentPage = index;

    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:NO];
    
    
}
-(NSTimer*)timer{
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerGo:) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}
-(NSMutableArray*)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
-(void)timerGo:(NSTimer*)timer{
    NSInteger index = _scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake((index+1)*self.scrollView.bounds.size.width, 0) animated:NO];
    if (index==self.dataSource.count) {
        self.pageControl.currentPage=0;
    }else if(index==0){
        self.pageControl.currentPage = self.dataSource.count;
    }else{
        self.pageControl.currentPage = index;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        [self addUI];
    }
    return self;
}

-(void)addUI{
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
}
-(void)loadImageForArray:(NSArray *)imageArr{
    self.scrollView.contentSize = CGSizeMake((imageArr.count+2) * (self.scrollView.bounds.size.width), self.scrollView.bounds.size.height);
    self.pageControl.numberOfPages = imageArr.count;
    [self.dataSource addObjectsFromArray:imageArr];
//    HeadViewModel * model = nil;
    AdListModel *model=nil;
    for (int i =0; i< imageArr.count+2; i++) {
        if (i==imageArr.count+1) {
            model = [imageArr firstObject];
        }else if (i==0){
            model = [imageArr lastObject];
        }else{
            model = imageArr[i-1];
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width,0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.src]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
    [self performSelector:@selector(timerBegin) withObject:nil afterDelay:2];
}
- (void)tapClick:(UITapGestureRecognizer *)tap{
    NSInteger index=self.scrollView.contentOffset.x/self.bounds.size.width;
    if (self.clickAtIndex) {
        _clickAtIndex(index);
    }
}
-(void)timerBegin{
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    
    if (index==self.dataSource.count+1) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
    }else if (index==0){
        [self.scrollView setContentOffset:CGPointMake(self.dataSource.count * self.scrollView.bounds.size.width, 0) animated:NO];
    }
    [self changePage];
}


-(void)changePage{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    
    if (index==0) {
        index = self.dataSource.count;
    }else if (index==self.dataSource.count+1){
        index = 1;
    }else{
        index--;
    }
    self.pageControl.currentPage = index;
}


@end
