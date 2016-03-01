//
//  HomeViewController.h
//  WeiTao
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 PJ. All rights reserved.
//

#import "PJRootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRViewController.h"
@interface HomeViewController : PJRootViewController<AVCaptureMetadataOutputObjectsDelegate,QRViewControllerDelegate>
@property (nonatomic,copy)void(^buttonClickAtIndex)(NSInteger index);


@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong, nonatomic)AVCaptureSession *session;

@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;
@end
