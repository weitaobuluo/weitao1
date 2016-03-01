//
//  AppSetting.h
//  monkeyDay
//
//  Created by Macintosh HD on 15/10/24.
//  Copyright (c) 2015年 taoYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppSetting : NSObject
/*
 App设置类(用于一键换肤)
 */


//菜单栏颜色
+(UIColor *)menuColor;

//透明度
+(UIColor *)menuColorWithAlpha:(float)alpha;




@end
