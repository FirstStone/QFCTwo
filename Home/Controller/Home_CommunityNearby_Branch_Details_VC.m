//
//  Home_CommunityNearby_Branch_Details_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/5/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Branch_Details_VC.h"

@interface Home_CommunityNearby_Branch_Details_VC ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *MyWKWebView;

@property (strong, nonatomic) IBOutlet UIView *BackView;

//@property (nonatomic, strong) JSContext *conttext;

@end

@implementation Home_CommunityNearby_Branch_Details_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*//创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     config.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0f;
    config.preferences = preferences;*/
  
    /*WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    [configuration.userContentController addScriptMessageHandler:self name:@"ToPayOrder"];*/
    
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    config.userContentController = [WKUserContentController new];
    //在创建wkWebView时，需要将被js调用的方法注册进去,oc与js端对应实现
    [config.userContentController addScriptMessageHandler:self name:@"ToPayOrder"];
    [config.userContentController addScriptMessageHandler:self name:@"Iosback"];
    [config.userContentController addScriptMessageHandler:self name:@"AndroidgoodsmainBtn"];
    [config.userContentController addScriptMessageHandler:self name:@"AndroidToGoodsDetails"];
    [config.userContentController addScriptMessageHandler:self name:@"AndroidAddressBtn"];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.processPool = [[WKProcessPool alloc] init];

    
    
    /*WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    [userContentController addScriptMessageHandler:self name:@"ToPayOrder"];
//    [userContentController addScriptMessageHandler:self name:@"Camera"];
    configuration.userContentController = userContentController;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;*/
    

    self.MyWKWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.tiaoxinkeji.com/dist/#/?,%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid], self.goodid]]];
    // 3.加载网页
    [self.MyWKWebView loadRequest:request];
    
    
    self.MyWKWebView.UIDelegate = self;
//    self.MyWKWebView.navigationDelegate = self;
//    self.MyWKWebView.allowsBackForwardNavigationGestures = YES;

    
    
    
    [self.BackView addSubview:self.MyWKWebView];
    [self.MyWKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BackView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

//     NSString *jsStr = @"getDataFromNative(params)";
//    [self.MyWKWebView evaluateJavaScript:jsStr completionHandler:nil];
//
//    [self.conttext evaluateScript:jsStr];
    
}

- (IBAction)HomeShopingCartClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_ShoppingCart_ViewController *shoppingVC = [[Home_ShoppingCart_ViewController alloc] init];
        [shoppingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shoppingVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.MyWKWebView.configuration.userContentController addScriptMessageHandler:self name:@"ToPayOrder"];
}
- (void)dealloc {
//    [super dealloc];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"ToPayOrder"];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"Iosback"];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"AndroidgoodsmainBtn"];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"AndroidToGoodsDetails"];
    [self.MyWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"AndroidAddressBtn"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (WKWebView *)MyWKWebView {
//    if (!_MyWKWebView) {
//        _MyWKWebView = [[WKWebView alloc] init];
//        _MyWKWebView.UIDelegate = self;
//        _MyWKWebView.navigationDelegate = self;
//        _MyWKWebView.allowsBackForwardNavigationGestures = YES;
//    }
//    return _MyWKWebView;
//}
//在发送请求之前 ，决定是否跳转
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
    if ([message.name isEqualToString:@"ToPayOrder"]) {
        NSLog(@"-------------------------------%@", message.body);
        NSDictionary *DataSoure = message.body;
        if ([[DataSoure objectForKey:@"orderids"] intValue]) {
            [self PayViewController:[DataSoure objectForKey:@"orderids"]];
        }
    }else if ([message.name isEqualToString:@"Iosback"]){
        NSDictionary *DataSoure = message.body;
        if ([DataSoure objectForKey:@"orderids"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([message.name isEqualToString:@"AndroidgoodsmainBtn"]){
        NSDictionary *DataSoure = message.body;
        if ([DataSoure objectForKey:@"merchantid"]) {
            Home_ShopStore_ViewController *ShopStoreVC = [[Home_ShopStore_ViewController alloc] init];
            ShopStoreVC.Shopid = [DataSoure objectForKey:@"merchantid"];
            [ShopStoreVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ShopStoreVC animated:YES];
        }
    }else if ([message.name isEqualToString:@"AndroidToGoodsDetails"]) {
        NSDictionary *DataSoure = message.body;
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.tiaoxinkeji.com/dist/#/?,%@,%@",[DataSoure objectForKey:@"uid"], [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]]]];
        // 3.加载网页
        [self.MyWKWebView loadRequest:request];
//        if ([DataSoure objectForKey:@"merchantid"]) {
//            Home_ShopStore_ViewController *ShopStoreVC = [[Home_ShopStore_ViewController alloc] init];
//            ShopStoreVC.Shopid = [DataSoure objectForKey:@"merchantid"];
//            [ShopStoreVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:ShopStoreVC animated:YES];
//        }
    }else if ([message.name isEqualToString:@"AndroidAddressBtn"]) {
//        NSDictionary *DataSoure = message.body;
        Mine_SetUPUI_MyAddress_NewAdd_VC *addVC = [[Mine_SetUPUI_MyAddress_NewAdd_VC alloc] init];
        [self.navigationController pushViewController:addVC animated:YES];
    }
}


- (void)PayViewController:(NSString *)orderid {
    Pay_ViewController *payVC = [[Pay_ViewController alloc] init];
    payVC.OrderID = orderid;
    [self.navigationController pushViewController:payVC animated:YES];
}

@end
