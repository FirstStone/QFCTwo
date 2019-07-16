//
//  Home_KDR_Novice_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_Novice_ViewController.h"

@interface Home_KDR_Novice_ViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet UIView *BackView;
@property (strong, nonatomic) WKWebView *MyWKWebView;


@end

@implementation Home_KDR_Novice_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyWKWebView = [[WKWebView alloc] init];
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.tiaoxinkeji.com/waste/#/jieshao"]];
    // 3.加载网页
    [self.MyWKWebView loadRequest:request];
    [self.BackView addSubview:self.MyWKWebView];
    [self.MyWKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BackView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
                                   
                                   
- (void)webView:(WKWebView* )webView decidePolicyForNavigationResponse:(WKNavigationResponse* )navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
                                       
    decisionHandler(WKNavigationResponsePolicyAllow);
}

                                   
@end
