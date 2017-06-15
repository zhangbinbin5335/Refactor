//
//  CTRootViewController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTRootViewController.h"
/* view controllers */
#import "CTHomePageController.h"
#import "CTQuotationController.h"
#import "CTInvestmentController.h"
#import "CTDiscoverController.h"
#import "CTUserController.h"
#import "CTNavigationController.h"

@interface CTRootViewController ()<UITabBarDelegate>
// tabbar item下划线
@property (nonatomic, strong) UILabel *underlineLabel;

@end

@implementation CTRootViewController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置viewControllers
    // Homepage
    CTHomePageController *homePageController = [[CTHomePageController alloc]init];
    CTNavigationController *homePageNavController = [[CTNavigationController alloc]
                                                     initWithRootViewController:homePageController];
    homePageNavController.tabBarItem = [self tabBarItemWithTitle:@"首页"];
    // 行情
    CTQuotationController *quotationController = [[CTQuotationController alloc]init];
    quotationController.tabBarItem = [self tabBarItemWithTitle:@"行情"];
    // 交易
    CTInvestmentController *investmentController = [[CTInvestmentController alloc]init];
    investmentController.tabBarItem = [self tabBarItemWithTitle:@"交易"
                                                          image:[UIImage imageNamed:@"tabbar_investment"]];
    [investmentController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                              NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}
                                                   forState:UIControlStateNormal | UIControlStateSelected];

    // 发现
    CTDiscoverController *discoverController = [[CTDiscoverController alloc]init];
    discoverController.tabBarItem = [self tabBarItemWithTitle:@"发现"];
    // 用户中心
    CTUserController *userController = [[CTUserController alloc]init];
    userController.tabBarItem = [self tabBarItemWithTitle:@"我的"];
    
    self.viewControllers = @[homePageNavController,
                             quotationController,
                             investmentController,
                             discoverController,
                             userController];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.underlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, 34, 2)];
    self.underlineLabel.backgroundColor = UIColorWithRGB(0x00A3CC);
    [self.tabBar addSubview:self.underlineLabel];
    self.selectedIndex = 0;
}

#pragma mark - 🔒private
-(UITabBarItem*)tabBarItemWithTitle:(NSString*)title{
    return  [self tabBarItemWithTitle:title image:nil];
}

-(UITabBarItem*)tabBarItemWithTitle:(NSString*)title image:(UIImage*)image{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]init];
    tabBarItem.title = title;
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorWithRGB(0x878787),
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}
                              forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorWithRGB(0x00A3CC),
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}
                              forState:UIControlStateSelected];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -10);
    if (image) {
        tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return tabBarItem;
}

#pragma mark - 🔄overwrite
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    //
    CGFloat tabbarWidth = self.tabBar.frame.size.width;
    NSUInteger itemCount = self.tabBar.items.count;
    CGFloat underlineWidth = tabbarWidth / itemCount;
    
    CGRect underLineFrame = self.underlineLabel.frame;
    underLineFrame.origin.x = selectedIndex * underlineWidth + (underlineWidth - underLineFrame.size.width) / 2.0;
    self.underlineLabel.frame = underLineFrame;
}
// tabbar item越界响应
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches allObjects][0];
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    // 需要越界响应的item index
    NSUInteger selectedIndex = 2;
    CGFloat tabbarWidth = self.tabBar.frame.size.width;
    CGFloat itemWidth = tabbarWidth / self.viewControllers.count;
    CGFloat tabbarHeight = self.tabBar.frame.size.height;
    if (touchPoint.x >= selectedIndex * itemWidth &&
        touchPoint.x <= (selectedIndex + 1) * itemWidth &&
        touchPoint.y >= self.view.frame.size.height - tabbarHeight + 10 - 20) {
        self.selectedIndex = selectedIndex;
    }
}

#pragma mark - 🚪public

#pragma mark - 🍐delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.selectedIndex = [tabBar.items indexOfObject:item];
}

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
