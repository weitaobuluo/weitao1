//
//  HeadDetailViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "HeadDetailViewController.h"

@interface HeadDetailViewController ()
@property (nonatomic,strong)UIWebView * webview;
@end

@implementation HeadDetailViewController
- (UIWebView *)webview{
    if (_webview==nil) {
        _webview=[[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    }
    return _webview;
}
- (void)loadView{
    self.view=self.webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
- (void)setModel:(AdListModel *)model{
    _model=model;
}
- (void)setDetailModel:(HomeDetailModel *)detailModel{
    _detailModel=detailModel;
}
- (void)loadData{
    if (_model==nil) {
        NSURL *url=[NSURL URLWithString:_detailModel.url];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        [self.webview loadRequest:request];
    }else{
    NSURL *url=[NSURL URLWithString:_model.url];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        [self.webview loadRequest:request];
    }
}
@end
