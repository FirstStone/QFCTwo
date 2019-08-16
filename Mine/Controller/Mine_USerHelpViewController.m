//
//  Mine_USerHelpViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/8/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_USerHelpViewController.h"

@interface Mine_USerHelpViewController ()

@property (strong, nonatomic) WKWebView *MyWKWebView;

@property (strong, nonatomic) IBOutlet UIView *BackView;


@end

@implementation Mine_USerHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyWKWebView = [[WKWebView alloc] init];
    // 2.创建请求
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"USerHelp"];
    NSURL *pathURL = [NSURL fileURLWithPath:filePath];
    [self.MyWKWebView loadRequest:[NSURLRequest requestWithURL:pathURL]];
    [self.BackView addSubview:self.MyWKWebView];
    [self.MyWKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BackView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (void)webView:(WKWebView* )webView decidePolicyForNavigationResponse:(WKNavigationResponse* )navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

@end
