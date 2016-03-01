//
//  AppDelegate.m
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "AppDelegate.h"
#import "PJHomeTabBarController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "MainSettingController.h"
#import "RESideMenu.h"
#import "LeadViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [UMSocialData setAppKey:@"5670c05d67e58e5d4c002ec4"];
     [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    BOOL isFirst=[[userDefaults objectForKey:@"FirstLogin"] boolValue];
    if (isFirst==NO) {
        //是第一次
        LeadViewController *lead=[[LeadViewController alloc]init];
        _window.rootViewController=lead;
    }else{
        [self changeRootViewController];
    }

    return YES;
}
- (void)changeRootViewController{
    //主视图
    PJHomeTabBarController *tabBar=[[PJHomeTabBarController alloc]init];
    MainSettingController *set=[[MainSettingController alloc]init];
    RESideMenu *menu=[[RESideMenu alloc]initWithContentViewController:tabBar leftMenuViewController:set rightMenuViewController:nil];
    self.window.rootViewController=menu;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
