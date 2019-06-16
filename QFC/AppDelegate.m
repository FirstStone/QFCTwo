//
//  AppDelegate.m
//  QFC
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UITabBarControllerDelegate, UIApplicationDelegate, WXApiDelegate>
@property (nonatomic, strong) UITabBarController *tabVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:User_Mid];
    }
    // appkey替换成自己在环信管理后台注册应用中的appkey
    EMOptions *options = [EMOptions optionsWithAppkey:@"1110190401216669#qfc"];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        NSString *Str = [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid];
        [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@", Str] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (aError==nil) {
                NSLog(@"注册成功");
            }
        }];
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@", Str] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"-----------------------------------登录成功");
                [[EMClient sharedClient] updatePushNotifiationDisplayName:[[NSUserDefaults standardUserDefaults] objectForKey:User_Nickname] completion:^(NSString *aDisplayName, EMError *aError) {
                    if (aError) {
                        NSLog(@"-----------------------------------昵称设置成功");
                    }
                }];
            }
        }];
    }
   
    [AMapServices sharedServices].apiKey = @"77f5eb7d30c87af9a368fed504d07571";
//    Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
    [WXApi registerApp:@"wx757cc9dd71fb1074"];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    self.tabVC = [self setTabBar];
    self.tabVC.delegate = self;
    self.tabVC.selectedIndex = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"%ld", (long)tabBarController.tabBar.selectedItem.tag);
    if (tabBarController.tabBar.selectedItem.tag == 4854887) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
            return YES;
        } else {
            Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
            [self.tabVC presentViewController:LoginVC animated:YES completion:Nil];
            return NO;
        }
    }
    return YES;
}


- (UITabBarController *)setTabBar {
    UITabBarController * contVC = [[UITabBarController alloc] init];
    Basic_NavigationController *FirstVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Home_ViewController alloc] init]];
    
    Basic_NavigationController *SecondVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Square_ViewController alloc] init]];
    
    Basic_NavigationController *ThreeVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Message_ViewController alloc] init]];
    
    Basic_NavigationController *FoureVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Mine_ViewController alloc] init]];
    
    //    contVC.viewControllers = @[FirstVC, SecondVC, ThreeVC, FoureVC];
    [contVC addChildViewController:FirstVC];
    [contVC addChildViewController:SecondVC];
    [contVC addChildViewController:ThreeVC];
    [contVC addChildViewController:FoureVC];
    
    //    UITabBarItem *item_1 = [contVC.tabBar.items objectAtIndex:0];
    //    contVC.tabBar.translucent = NO;
    //    contVC.tabBar.tintColor = EK_Color_NavigationBack;
    FirstVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Home_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FirstVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Home_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FirstVC.tabBarItem.title = @"首页";
    FirstVC.tabBarItem.tag = 4854885;
    
    //    UITabBarItem *item_2 = [contVC.tabBar.items objectAtIndex:1];
    SecondVC.tabBarItem.image = [[UIImage imageNamed:@"icon_ square_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SecondVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_ square_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SecondVC.tabBarItem.title = @"广场";
    SecondVC.tabBarItem.tag = 4854886;
    
    //    UITabBarItem *item_3 = [contVC.tabBar.items objectAtIndex:2];
    ThreeVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Message_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ThreeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Message_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ThreeVC.tabBarItem.title = @"消息";
    ThreeVC.tabBarItem.tag = 4854887;
    
    //    UITabBarItem *item_4 = [contVC.tabBar.items objectAtIndex:3];
    FoureVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Mine_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FoureVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Mine_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FoureVC.tabBarItem.title = @"我的 ";
    FoureVC.tabBarItem.tag = 4854888;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:QFC_Color_Green} forState:UIControlStateSelected];
    
    
    QFCTabBar *PublishTabBar = [[QFCTabBar alloc] init];
    [PublishTabBar.plusItem addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [contVC setValue:PublishTabBar forKey:@"tabBar"];
    return contVC;
}

- (void)plusAction:(UIButton *)button {
    XNLog(@"发布");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Publish_ViewController *pVC = [[Publish_ViewController alloc] init];
        Basic_NavigationController *BNAV = [[Basic_NavigationController alloc] initWithRootViewController:pVC];
        [self.tabVC presentViewController:BNAV animated:YES completion:Nil];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.tabVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VersionAPP" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setUPUIMapView" object:nil];
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [WXApi handleOpenURL:url delegate:self];
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *subTitle = @"";
            NSString *resultStatus = resultDic[@"resultStatus"];
            switch ([resultStatus intValue]) {
                    case 9000:
                    subTitle = @"支付成功";
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipalyPaySuccess" object:nil];
                    //移除购买成功商品
                    //                     [self removesuessInfo];
                    break;
                    case 8000:
                {
                    subTitle = @"正在处理中";
                    
                }
                    break;
                    case 4000:
                {
                    subTitle = @"支付失败";
                }
                    break;
                    case 6001:
                {
                    subTitle = @"已取消";
                }
                    break;
                    case 6002:
                {
                    subTitle = @"网络连接出错";
                }
                    break;
                default:
                    break;
            }
            NSLog(@"resultStatus==%@",resultStatus);
            [SVProgressHUD showSuccessWithStatus:subTitle];
            [SVProgressHUD dismissWithDelay:0.7f];
        }];
    }
    return YES;
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
//    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    //    支付结果回调
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:{
                //支付返回结果，实际支付结果需要去自己的服务器端查询
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipalyPaySuccess" object:nil];
                
                break;
            }
            default:{
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

@end
