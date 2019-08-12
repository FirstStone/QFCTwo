//
//  Basic_NavigationController.m
//  QFC
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "Basic_NavigationController.h"

@interface Basic_NavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic,strong) id popDelegate;

@end

@implementation Basic_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PustViewToSelfView) name:WANG_LUO_STATE object:nil];
    //代理
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
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

- (void)PustViewToSelfView {
    NotDataSoureVC *vc = [[NotDataSoureVC alloc] init];
//    UINavigationController *NAv = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WANG_LUO_STATE object:nil];
}

#pragma UINavigationControllerDelegate方法
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //实现滑动返回功能
    //清空滑动返回手势的代理就能实现
    self.interactivePopGestureRecognizer.delegate =  viewController == self.viewControllers[0]? self.popDelegate : nil;
}

@end
