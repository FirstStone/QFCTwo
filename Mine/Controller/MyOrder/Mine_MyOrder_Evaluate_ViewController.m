//
//  Mine_MyOrder_Evaluate_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/6/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_Evaluate_ViewController.h"

@interface Mine_MyOrder_Evaluate_ViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *MyWKWebView;
@property (strong, nonatomic) IBOutlet UIView *BackView;

@end

@implementation Mine_MyOrder_Evaluate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    config.userContentController = [WKUserContentController new];
    //在创建wkWebView时，需要将被js调用的方法注册进去,oc与js端对应实现
    [config.userContentController addScriptMessageHandler:self name:@"Iosback"];
    [config.userContentController addScriptMessageHandler:self name:@"IosOrderEvaluatePost"];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.processPool = [[WKProcessPool alloc] init];
    
    
    self.MyWKWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.tiaoxinkeji.com/dist/#/IosEvaluate/?,%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid], self.OrderID]]];
    // 3.加载网页
    [self.MyWKWebView loadRequest:request];
    
    
    self.MyWKWebView.UIDelegate = self;
    //    self.MyWKWebView.navigationDelegate = self;
    //    self.MyWKWebView.allowsBackForwardNavigationGestures = YES;
    
    
    
    
    [self.BackView addSubview:self.MyWKWebView];
    [self.MyWKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BackView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)dealloc {
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"Iosback"];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"IosOrderEvaluatePost"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)webView:(WKWebView* )webView decidePolicyForNavigationResponse:(WKNavigationResponse* )navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//
//    NSLog(@"%s", __FUNCTION__);
//    // 禁用选中效果
////    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
////    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
//
//}

//接收到服务器 跳转请求之后调用，即从一个h5 进入另一个h5
//在收到响应之前，决定是否跳转
- (void)webView:(WKWebView* )webView decidePolicyForNavigationAction:(WKNavigationAction* )navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *str = navigationAction.request.URL.absoluteString;//获取当前正在请求的url
    NSLog(@"%@",str);
    
    if ([str isEqualToString:[NSString stringWithFormat:@"http://d106.ichuk.com/Shop/Cart"]]) {
        //详情跳转
        //        MKJShoppingCartViewController *cartVC = [[MKJShoppingCartViewController alloc] init];
        //        [self.navigationController pushViewController:cartVC animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

#pragma mark----WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"Iosback"]) {
        NSLog(@"-------------------------------%@", message.body);
        [self.navigationController popViewControllerAnimated:YES];
//        NSDictionary *DataSoure = message.body;
//        if ([[DataSoure objectForKey:@"orderids"] intValue]) {
//            [self PayViewController:[DataSoure objectForKey:@"orderids"]];
//        }
    }else if ([message.name isEqualToString:@"IosOrderEvaluatePost"]) {
        NSLog(@"-------------------------------%@", message.body);
        NSDictionary *DataSoure = message.body;
        if ([[DataSoure objectForKey:@"status"] intValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


- (void)PayViewController:(NSString *)orderid {
    Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
    payVC.OrderID = orderid;
    [self.navigationController pushViewController:payVC animated:YES];
}

@end
