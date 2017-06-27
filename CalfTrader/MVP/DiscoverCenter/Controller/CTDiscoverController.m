//
//  CTDiscoverController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTDiscoverController.h"
#import "CTRadarScanView.h"
#import "CTTextView.h"

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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [radarView stopAnimate];
    });
    
    CTTextView *textView = [[CTTextView alloc]initWithFrame:CGRectMake(0, 300, 200, 100)];
    textView.placeholder = @"self.placeholderLabel.frame = self.bounds;";
    textView.layer.borderColor = [UIColor yellowColor].CGColor;
    textView.layer.borderWidth = 3;
    textView.layer.cornerRadius = 10;
    [self.view addSubview:textView];
//    UIImage *navbarBgImage = [UIImage imageNamed:@"navbar_background"];
//    UIImage *newImage = [navbarBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(0,
//                                                                                    navbarBgImage.size.width/2. - 10,
//                                                                                    0,
//                                                                                    navbarBgImage.size.width/2.-10)];
//    [self.navigationController.navigationBar setBackgroundImage:newImage
//                                                  forBarMetrics:UIBarMetricsDefault];
    
    
  
//   UITextView *textview= [[UITextView alloc]initWithFrame:CGRectMake(10, 300, 250, 170)];
//    NSString *html = [NSString stringWithFormat:@"<font color='red'>A</font><br/> shared photo of <font color='red'>B</font> with <font color='red'>C</font>, <font color='red'>D</font> "];
//    [textview setValue:html forKey:@"contentToHTMLString"];
//    textview.textAlignment = NSTextAlignmentLeft;
//    textview.editable = NO;
//    textview.font = [UIFont fontWithName:@"Verdana" size:20.0];
//    [self.view addSubview:textview];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
