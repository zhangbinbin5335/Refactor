//
//  CTDiscoverController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTDiscoverController.h"
#import "CTRadarScanView.h"

@interface CTDiscoverController ()

@end

@implementation CTDiscoverController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CTRadarScanView *radarView = [[CTRadarScanView alloc]initWithFrame:CGRectMake(0,
                                                                                  100,
                                                                                  100,
                                                                                  100)];
    [self.view addSubview:radarView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [radarView startAnimate];
    });
    
//    UIImage *navbarBgImage = [UIImage imageNamed:@"navbar_background"];
//    UIImage *newImage = [navbarBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0,
//                                                                                    navbarBgImage.size.width/2. - 10,
//                                                                                    0,
//                                                                                    navbarBgImage.size.width/2.-10)];
//    [self.navigationController.navigationBar setBackgroundImage:newImage
//                                                  forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
