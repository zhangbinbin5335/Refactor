//
//  CTQuotationController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTQuotationController.h"
#import "CTBadgeButton.h"
#import "CTPageIndicatorView.h"

@interface CTQuotationController ()
<UIPageViewControllerDelegate,
UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSArray <UIViewController *> *dataSource;
@property (nonatomic, strong) CTPageIndicatorView *indicatorView;
@property (nonatomic, assign) NSInteger currentIndex; // 当前vc索引

@end

@implementation CTQuotationController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
    CTBadgeButton *badgeButton = [CTBadgeButton buttonWithType:UIButtonTypeRoundedRect];
    badgeButton.backgroundColor = [UIColor yellowColor];
    badgeButton.frame = CGRectMake(100, 100, 70, 50);
    [badgeButton setTitle:@"梅.梅" forState:UIControlStateNormal];
    badgeButton.badgeText = @"S.B";
    badgeButton.minBadgeWidth = 15;
    // badgeButton.badgeBackColor = [UIColor greenColor];
    // badgeButton.badgeTextColor = [UIColor redColor];
    
    [self.view addSubview:badgeButton];
     */
    
    CTViewController *leftVC = [CTViewController new];
    leftVC.title = @"left";
    
    CTViewController *mindVC = [CTViewController new];
    mindVC.title = @"mind";
    
    CTViewController *rightVC = [CTViewController new];
    rightVC.title = @"right";
    _dataSource = @[leftVC, mindVC, rightVC];
    
    _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                           options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    self.currentIndex = 1;
    [_pageVC setViewControllers:@[mindVC]
                      direction:UIPageViewControllerNavigationDirectionReverse
                       animated:YES
                     completion:nil];
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    self.indicatorView = [[CTPageIndicatorView alloc]init];
    self.indicatorView.dataSource = @[@{@"title" : @"xx1"},
                                      @{@"title" : @"xx2"},
                                      @{@"title" : @"xx3",
                                        @"badge" : @"1"}];
    [self.view addSubview:self.indicatorView];
    self.indicatorView.selectedIndex = 1;
    __weak typeof(self) weakSelf = self;
    [self.indicatorView setDidSelectCompletion:^(NSInteger index){
        UIPageViewControllerNavigationDirection direction;
        if (index == weakSelf.currentIndex) {
            return ;
        }else if (index > weakSelf.currentIndex){
            direction = UIPageViewControllerNavigationDirectionForward;
        }else{
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        weakSelf.currentIndex = index;
        [weakSelf.pageVC setViewControllers:@[weakSelf.dataSource[index]]
                                  direction:direction
                                   animated:YES
                                 completion:nil];
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.indicatorView.mas_bottom);
    }];
}

#pragma mark - 🔒private

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate
#pragma mark -- UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_dataSource indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return [_dataSource objectAtIndex:index - 1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_dataSource indexOfObject:viewController];
    if (index == 2) {
        return nil;
    }
    return [_dataSource objectAtIndex:index + 1];
}

#pragma mark -- UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed{
    self.currentIndex = [self.dataSource indexOfObject:pageViewController.viewControllers[0]];
    self.indicatorView.selectedIndex = self.currentIndex;
}

#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter

@end
