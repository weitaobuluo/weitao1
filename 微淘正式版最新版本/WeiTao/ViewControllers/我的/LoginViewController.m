//
//  LoginViewController.m
//  WeiTao
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "LoginViewController.h"
#import "ResignViewController.h"
#import "User.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#define BUTTON_TAG 10
#define SHARE_TAG 30
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * name;
@property (nonatomic,strong)UITextField * password;
@property (nonatomic,strong)UIButton *button;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationItem];
    [self addUI];
    //添加键盘通知
    [self createBoard];
}
- (void)createBoard{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotice:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotice:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)receiveNotice:(NSNotification *)notice{
    if ([notice.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect rect=self.view.bounds;
        rect.origin.y=60;
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
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-image.size.width)/2,25, image.size.width, image.size.height)];
    imageview.image= image;
    [self.view addSubview:imageview];
    _name=[[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(imageview.frame)+10, kUIScreen_Size.width-120, 40)];
    _name.layer.cornerRadius=5;
    _name.layer.masksToBounds=YES;
    _name.layer.borderWidth=2;
    _name.placeholder=@"请输入用户名";
    _name.layer.borderColor=[[UIColor whiteColor]CGColor];
    [self.view addSubview:_name];
    _password=[[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(_name.frame)+10, kUIScreen_Size.width-120, 40)];
    _password.layer.cornerRadius=5;
    _password.layer.masksToBounds=YES;
    _password.layer.borderWidth=2;
    _password.clearButtonMode=UITextFieldViewModeWhileEditing;
    _password.placeholder=@"请输入密码";
    _password.layer.borderColor=[[UIColor whiteColor]CGColor];
    [self.view addSubview:_password];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    view.backgroundColor=[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    _name.leftView=view;
    _name.clearButtonMode=UITextFieldViewModeWhileEditing;
    _name.leftViewMode=UITextFieldViewModeAlways;
    _password.secureTextEntry=YES;
    _password.leftView=view1;
    _password.leftViewMode=UITextFieldViewModeAlways;
    NSArray *names=@[@"取消",@"登陆"];
    for (int i=0;i<names.count; i++) {
       UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-2*60)/3*(i+1)+60*i, CGRectGetMaxY(_password.frame)+20,60, 40)];
        button.tag=BUTTON_TAG+i;
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor grayColor];
        button.layer.cornerRadius=5;
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=2;
        button.layer.borderColor=[[UIColor whiteColor]CGColor];
        [button addTarget:self action:@selector(logButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_password.frame)+60, kUIScreen_Size.width, 40)];
    label.text=@"——————第三方登陆——————";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    NSArray *picNames=@[@"share_logo_qq",@"share_logo_xinlang"];
    for (int i=0; i<picNames.count; i++) {
        UIImage *image=[UIImage imageNamed:picNames[i]];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kUIScreen_Size.width-2*image.size.width)/3*(i+1)+image.size.width*i, CGRectGetMaxY(label.frame)+5,image.size.width,image.size.height)];
        button.backgroundColor=[UIColor grayColor];
        button.layer.cornerRadius=5;
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=2;
        button.tag=SHARE_TAG+i;
        button.layer.borderColor=[[UIColor whiteColor]CGColor];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)logButtonClick:(UIButton *)button{
    NSInteger index=button.tag-BUTTON_TAG;
    switch (index) {
        case 0:
            [self returnLast];
            break;
        case 1:
            [self log];
            break;
        default:
            break;
    }
}
- (void)returnLast{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)log{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSArray *arr=[user objectForKey:@"infos"];
    NSMutableArray *mulArr=[NSMutableArray arrayWithArray:arr];
    for (int i=0; i<arr.count; i++) {
        if ([_name.text isEqualToString:mulArr[i][@"username"]]&&[_password.text isEqualToString:mulArr[i][@"password"]]) {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];
            [self.delegate loadUserName:_name.text with:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆失败,请重新登陆" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];
        }
    }
}
#pragma mark - 第三方登陆
- (void)shareButtonClick:(UIButton *)button{
    NSInteger index=button.tag-SHARE_TAG;
    switch (index) {
        case 0:
            [self logQQ];
            break;
        case 1:
            [self logWeibo];
            break;
        default:
            break;
    }
}
- (void)logQQ{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self.delegate loadUserName:snsAccount.userName with:snsAccount.iconURL];
            [self.navigationController popViewControllerAnimated:YES];
        }});
}
- (void)logWeibo{
   UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self.delegate loadUserName:snsAccount.userName with:snsAccount.iconURL];
            [self.navigationController popViewControllerAnimated:YES];
        }});

}
- (void)addNavigationItem{
    self.title=@"登陆";
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=item;
}
- (void)buttonClick:(UIButton *)button{
    ResignViewController *resign=[[ResignViewController alloc]init];
    [self.navigationController pushViewController:resign animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder];
    [_password resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_name) {
        [_password becomeFirstResponder];
    }
    if (textField==_password) {
        [_password resignFirstResponder];
    }
    return YES;
}
@end
