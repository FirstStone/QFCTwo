//
//  Basic_NavigationController.m
//  QFC
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "Basic_NavigationController.h"

@interface Basic_NavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation Basic_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = self;
//    //设置全屏滚动
//    id target = self.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    [self.view addGestureRecognizer:pan];
//    self.interactivePopGestureRecognizer.enabled = NO;
}
/*- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //判断如果是需要隐藏导航控制器的类，则隐藏
    BOOL isHideNav = ([viewController isKindOfClass:[viewController class]] || [viewController isKindOfClass:[Login_PhoneCodeViewControlloer class]]);
    [self setNavigationBarHidden:isHideNav animated:YES];
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)zer {
    
}*/

@end
