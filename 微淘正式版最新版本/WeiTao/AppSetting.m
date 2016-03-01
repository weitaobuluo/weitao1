//
//  AppSetting.m
//  monkeyDay
//
//  Created by Macintosh HD on 15/10/24.
//  Copyright (c) 2015年 taoYun. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting



+(UIColor *)menuColorWithAlpha:(float)alpha
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user integerForKey:@"red"] == 0) {
        return[UIColor colorWithRed:249/255.0 green:69/255.0 blue:123/255.0 alpha:1];
    }
    float red = [user integerForKey:@"red"]/255.0;
    float green = [user integerForKey:@"green"]/255.0;
    float blue = [user integerForKey:@"blue"]/255.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

+(UIColor *)menuColor
{
    return [self menuColorWithAlpha:1];
}

@end
