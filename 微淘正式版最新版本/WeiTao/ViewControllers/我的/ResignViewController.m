//
//  ResignViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "ResignViewController.h"
#define BUTTON_TAG 20
@interface ResignViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * name;
@property (nonatomic,strong)UITextField * password;
@property (nonatomic,strong)UITextField * confirm;
@property (nonatomic,strong)UIButton *button;

@end

@implementation ResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    [self createBoard];
    self.title=@"注册";
}
- (void)createBoard{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotice:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotice:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)receiveNotice:(NSNotification *)notice{
    if ([notice.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect rect=self.view.bounds;
        rect.origin.y=85;
        self.view.bounds=rect;
    }else if ([notice.name isEqualToString:UIKeyboardWillHideNotification]) {
        CGRect rect=self.view.bounds;
        rect.origin.y=0;
        self.view.bounds=rect;
    }
}

- (void)addUI{
    self.view.backgroundColor=[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    UIImage *image=[UIImage imageNamed:@"2.png"];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-image.size.width)/2,60, image.size.width, image.size.height)];
    imageview.image= image;
    [self.view addSubview:imageview];
    _name=[[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(imageview.frame)+20, kUIScreen_Size.width-120, 40)];
    _name.clearButtonMode=UITextFieldViewModeWhileEditing;
    _name.layer.cornerRadius=5;
    _name.layer.masksToBounds=YES;
    _name.layer.borderWidth=2;
    _name.placeholder=@"请输入用户名";
    _name.layer.borderColor=[[UIColor whiteColor]CGColor];
    [self.view addSubview:_name];
    _password=[[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(_name.frame)+10, kUIScreen_Size.width-120, 40)];
    _password.clearButtonMode=UITextFieldViewModeWhileEditing;
    _password.layer.cornerRadius=5;
    _password.layer.masksToBounds=YES;
    _password.layer.borderWidth=2;
    _password.placeholder=@"请输入密码";
    _password.layer.borderColor=[[UIColor whiteColor]CGColor];
    [self.view addSubview:_password];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    view.backgroundColor=[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    _name.leftView=view;
    _name.leftViewMode=UITextFieldViewModeAlways;
    _password.leftView=view1;
    _password.leftViewMode=UITextFieldViewModeAlways;
    _confirm=[[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(_password.frame)+10, kUIScreen_Size.width-120, 40)];
        _confirm.clearButtonMode=UITextFieldViewModeWhileEditing;
        _confirm.layer.cornerRadius=5;
        _confirm.layer.masksToBounds=YES;
        _confirm.layer.borderWidth=2;
        _confirm.layer.borderColor=[[UIColor whiteColor]CGColor];
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    _confirm.placeholder=@"请再次输入密码";
    _confirm.leftView=view2;
    _confirm.leftViewMode=UITextFieldViewModeAlways;
        [self.view addSubview:_confirm];
    _password.secureTextEntry=YES;
    _confirm.secureTextEntry=YES;
    NSArray *names=@[@"取消",@"注册"];
    for (int i=0;i<names.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-2*60)/3*(i+1)+60*i, CGRectGetMaxY(_confirm.frame)+20,60, 40)];
        button.tag=BUTTON_TAG+i;
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor grayColor];
        button.layer.cornerRadius=5;
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=2;
        button.layer.borderColor=[[UIColor whiteColor]CGColor];
        [button addTarget:self action:@selector(resignClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)resignClick:(UIButton *)button{
    NSInteger index=button.tag-BUTTON_TAG;
    switch (index) {
        case 0:
            [self returnLog];
            break;
        case 1:
            [self resign];
            break;
        default:
            break;
    }
}
- (void)returnLog{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)resign{
    if ([_password.text isEqualToString:_confirm.text]) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSArray *array=[user objectForKey:@"infos"];
        if (array==nil) {
            NSArray *infos=[[NSArray alloc]init];
            [user setObject:infos forKey:@"infos"];
        }
        NSArray *arr=[user objectForKey:@"infos"];
        NSMutableArray *mulArr=[[NSMutableArray alloc]init];
        mulArr.array=arr;
        NSString *name=_name.text;
        NSString *password=_password.text;
        NSDictionary *dic=@{@"username":name,@"password":password};
        [mulArr addObject:dic];
        [user setObject:mulArr forKey:@"infos"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder];
    [_password resignFirstResponder];
    [_confirm resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_name) {
        [_password becomeFirstResponder];
    }
    if (textField==_password) {
        [_password resignFirstResponder];
        [_confirm becomeFirstResponder];
    }
    if (textField==_confirm) {
        [_confirm resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if (str.length>11) {
        return NO;
    }
    return YES;
}
@end
