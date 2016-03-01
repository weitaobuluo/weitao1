//
//  WalkClickViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "WalkClickViewController.h"

@interface WalkClickViewController ()
@property (nonatomic,strong)UIWebView * webview;
@end

@implementation WalkClickViewController
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
- (void)setModel:(ArtListModel *)model{
    _model=model;
}

- (void)loadData{
        NSURL *url=[NSURL URLWithString:_model.url];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        [self.webview loadRequest:request];
}

@end
