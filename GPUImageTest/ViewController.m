//
//  ViewController.m
//  GPUImageTest
//
//  Created by Daniel iMac on 2016/1/7.
//  Copyright © 2016年 Speed 3D Inc. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property(nonatomic, weak) IBOutlet GPUImageView *filteredVideoView;

@property(nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property(nonatomic, strong) GPUImageFilter *customFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    [self.videoCamera addTarget:self.customFilter];
    [self.customFilter addTarget:self.filteredVideoView];
    
    [self.videoCamera startCameraCapture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazily initialized

- (GPUImageVideoCamera *)videoCamera {
    if (!_videoCamera) {
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    }
    return _videoCamera;
}

- (GPUImageFilter *)customFilter {
    if (!_customFilter) {
        _customFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomFilter"];
    }
    return _customFilter;
}

@end
