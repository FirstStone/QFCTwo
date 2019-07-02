//
//  AppDelegate.m
//  QFC
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "AppDelegate.h"
static NSString *appKey = @"f74baa13307e0fdae9225276";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<UITabBarControllerDelegate, UIApplicationDelegate, WXApiDelegate, JPUSHRegisterDelegate>
@property (nonatomic, strong) UITabBarController *tabVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:User_Mid];
    }
    //激光推送
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
//            self.registrationID = registrationID;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
                //        [JPUSHService deleteAlias:nil seq:123];
                [JPUSHService setAlias:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                    [self inputResponseCode:iResCode content:iAlias andSeq:seq];
                } seq:123];
            }
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    // appkey替换成自己在环信管理后台注册应用中的appkey
    EMOptions *options = [EMOptions optionsWithAppkey:@"1110190401216669#qfc"];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        NSString *Str = [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid];
        [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@Ky", Str] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (aError==nil) {
                NSLog(@"注册成功");
            }
        }];
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@Ky", Str] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
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
//激光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    [self play];
    //清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    [self play];
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
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
    //在这个方法里输入如下清除方法
    [application setApplicationIconBadgeNumber:0]; //清除角标
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//清除APP所有通知消息
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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
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
    }else {//微信登录if ([url.host isEqualToString:@"oauth"])
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

/*- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
//    [WXApi handleOpenURL:url delegate:self];
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
    }else {//微信登录if ([url.host isEqualToString:@"oauth"])
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}*/

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
    }else if ([resp isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD py_showError:@"微信授权失败" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7];
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        NSMutableDictionary *dataSoure = [[NSMutableDictionary alloc] init];
        [dataSoure setObject:code forKey:@"code"];
        [self getWeiXinOpenId:code];
    }
}


//通过code获取access_token，openid，unionid
- (void)getWeiXinOpenId:(NSString *)code{
    /*
     appid    是    应用唯一标识，在微信开放平台提交应用审核通过后获得
     secret    是    应用密钥AppSecret，在微信开放平台提交应用审核通过后获得
     code    是    填写第一步获取的code参数
     grant_type    是    填authorization_code
     */
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx757cc9dd71fb1074",@"6fbf04050078a899b48e05a3cbbfda53",code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data1 = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (!data1) {
            [MBProgressHUD py_showError:@"微信授权失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7];
            return ;
        }
        
        // 授权成功，获取token、openID字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"token、openID字典===%@",dic);
        NSString *access_token = dic[@"access_token"];
        NSString *openid= dic[@"openid"];
        
        //         获取微信用户信息
        [self getUserInfoWithAccessToken:access_token WithOpenid:openid];
        
    });
}
-(void)getUserInfoWithAccessToken:(NSString *)access_token WithOpenid:(NSString *)openid
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 获取用户信息失败
            if (!data) {
                [MBProgressHUD py_showError:@"微信授权失败" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7];
                return ;
            }
            
            // 获取用户信息字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //用户信息中没有access_token 我将其添加在字典中
            [dic setValue:access_token forKey:@"token"];
            NSLog(@"用户信息字典:===%@",dic);
            //保存改用户信息(我用单例保存)
            [Singleton sharedSingleton].weiXinIfon = dic;
            //微信返回信息后,会跳到登录页面,添加通知进行其他逻辑操作
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiChatOK" object:nil];
            
        });
        
    });
    
}

- (void)play {
    NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/叮咚 您有新的订单 请及时处理.wav"];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
