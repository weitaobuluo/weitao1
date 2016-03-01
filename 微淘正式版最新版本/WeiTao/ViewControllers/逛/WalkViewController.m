//
//  WalkViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "WalkViewController.h"
#import "WalkExperienceController.h"
#import "WalkMatchViewController.h"
#import "WalkNewViewController.h"
#import "WalkTidePersonController.h"
#import "WalkTopicViewController.h"
#import "WalkTideViewController.h"
#import "WalkRootController.h"
#import "HomeTableViewCell.h"
#import "DetailViewController.h"
#import "WalkClickViewController.h"
#import "UMSocial.h"
#define Button_Tag 10
@interface WalkViewController ()

@end

@implementation WalkViewController
{
    UIScrollView *_headScrollView;
    NSMutableArray * _buttonArr;
    WalkNewViewController *_walkNew;
    WalkTopicViewController *_walkTop;
    WalkMatchViewController *_match;
    WalkTideViewController *_tide;
    WalkTidePersonController *_tidePerson;
    WalkExperienceController *_experience;
    NSInteger _scrollPage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _isBig=NO;
    self.tableView.alwaysBounceVertical=NO;
    self.tableView.alwaysBounceHorizontal=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self addHeadScrollView];
    [self addNavigationItem];
    [self addDidSelect];
    self.tableView.scrollEnabled=NO;
//    [self setTableViewFrame];
}
//- (void)setTableViewFrame{
//    CGRect rect=self.tableView.frame;
//    rect=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    self.tableView.frame=rect;
//}
- (void)addDidSelect{
      __weak WalkViewController *weakSelf=self;
    _walkNew.walkClick=^(ArtListModel * model){
        WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };
    _walkTop.walkClick=^(ArtListModel * model){
    WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };
    _match.walkClick=^(ArtListModel * model){
    WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };
    _tide.walkClick=^(ArtListModel * model){
    WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };
    _tidePerson.walkClick=^(ArtListModel * model){
    WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };
    _experience.walkClick=^(ArtListModel * model){
    WalkClickViewController *view=[[WalkClickViewController alloc]init];
        view.model=model;
        [weakSelf.navigationController pushViewController:view animated:YES];
    };

}
- (void)loadData
{
    _walkNew=[[WalkNewViewController alloc]init];
    _walkTop=[[WalkTopicViewController alloc]init];
    _match=[[WalkMatchViewController alloc]init];
    _tide=[[WalkTideViewController alloc]init];
    _tidePerson=[[WalkTidePersonController alloc]init];
    _experience=[[WalkExperienceController alloc]init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    if (cell==nil) {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homecell"];
    }
    NSArray *viewControllers=@[_walkNew,_walkTop,_match,_tide,_tidePerson,_experience];
    cell.array=viewControllers;
    cell.scrollAtIndex=^(NSInteger index){
        [self loadScrollAtIndex:index];
    };
    cell.page=_scrollPage;
    return cell;
}
- (void)loadScrollAtIndex:(NSInteger )index{
    UIButton *button=(id)[self.view viewWithTag:Button_Tag+index];
    if (index==4) {
        _headScrollView.contentOffset=CGPointMake(kUIScreen_Size.width/5, 0);
    }
    if (index==1) {
         _headScrollView.contentOffset=CGPointMake(0, 0);
    }
    button.selected=YES;
    for (int i=0; i<_buttonArr.count; i++) {
        UIButton *button=_buttonArr[i];
        if (button.selected==NO) {
            [UIView animateWithDuration:1 animations:^{
                button.titleLabel.font=[UIFont systemFontOfSize:18];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }];
        }
        else{
            [UIView animateWithDuration:1 animations:^{
                button.titleLabel.font=[UIFont systemFontOfSize:22];
                [button setTitleColor:[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
                
            }];
        }
        button.selected=NO;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kUIScreen_Size.height;
}
#pragma mark - 添加头标题
- (void)addHeadScrollView{
    _buttonArr=[[NSMutableArray alloc]init];
    _headScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,-50, kUIScreen_Size.width,50)];
    _headScrollView.delegate=self;
    _headScrollView
    .contentSize=CGSizeMake(kUIScreen_Size.width/5*6, 50);
    _headScrollView.showsHorizontalScrollIndicator=NO;
    NSArray * array=@[@"最新",@"话题",@"搭配",@"潮人",@"潮品",@"经验"];
    for (int i=0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width+60)/6*i, 10, (kUIScreen_Size.width+60)/6, 30)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.tag=Button_Tag+i;
        button.titleLabel.font=[UIFont systemFontOfSize:18];
        if(i==0){
        button.titleLabel.font=[UIFont systemFontOfSize:22];
        [button setTitleColor:[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollView addSubview:button];
        [_buttonArr addObject:button];
    }
    [self.view addSubview:_headScrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
- (void)addNavigationItem{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=item;
}
- (void)headButtonClick:(UIButton *)button{
   
    if (_isClick==NO) {
        [UIView animateWithDuration:1 animations:^{
            CGRect rect=_headScrollView.frame;
            rect=CGRectMake(0, 0, kUIScreen_Size.width, 50);
            _headScrollView.frame=rect;
            CGRect rect1=self.tableView.frame;
            rect1=CGRectMake(0, 50, kUIScreen_Size.width, kUIScreen_Size.width+64+50+10);
            self.tableView.frame=rect1;
        }];
    _isClick=YES;
    }else{
        [UIView animateWithDuration:1 animations:^{
            CGRect rect=_headScrollView.frame;
            rect=CGRectMake(0, -50, kUIScreen_Size.width, 50);
            _headScrollView.frame=rect;
            CGRect rect1=self.tableView.frame;
            rect1=self.view.bounds;
            self.tableView.frame=rect1;
            }];
        _isClick=NO;
    }
    
}
- (void)buttonClick:(UIButton *)button{
   _scrollPage=button.tag-Button_Tag;
    button.selected=YES;
    for (int i=0; i<_buttonArr.count; i++) {
            UIButton *button=_buttonArr[i];
            if (button.selected==NO) {
                [UIView animateWithDuration:1 animations:^{
                    button.titleLabel.font=[UIFont systemFontOfSize:18];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }];
            }
    else{
                [UIView animateWithDuration:1 animations:^{
                    button.titleLabel.font=[UIFont systemFontOfSize:22];
                [button setTitleColor:[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
    
                }];
        }
        button.selected=NO;
        
        [self.tableView reloadData];
}
}

@end
