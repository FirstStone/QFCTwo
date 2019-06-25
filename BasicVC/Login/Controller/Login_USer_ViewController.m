//
//  Login__USer_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Login_USer_ViewController.h"

@interface Login_USer_ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *PhoneCode_BT;


@property (nonatomic, strong) UITabBarController *tabVC;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber_Field;
@property (strong, nonatomic) IBOutlet UITextField *Password_Field;

@property (strong, nonatomic) IBOutlet UIView *Down_View;

@property (strong, nonatomic) IBOutlet UIButton *WX_BT;

@property (strong, nonatomic) IBOutlet UIButton *QQ_BT;


@end

@implementation Login_USer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiChatOK) name:@"weiChatOK" object:NULL];
    if ([WXApi isWXAppInstalled]) {
        self.Down_View.hidden = NO;
        self.WX_BT.hidden = NO;
    }else {
        self.Down_View.hidden = YES;
        self.WX_BT.hidden = YES;
    }
}

- (IBAction)POPHomeView:(id)sender {
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)PopToLastViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AgreementLiftButtonClick:(id)sender {
    Mine_Agreement_VC *VC = [[Mine_Agreement_VC alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.Type = 1;
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)AgreementRightButtonClick:(id)sender {
    Mine_Agreement_VC *VC = [[Mine_Agreement_VC alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.Type = 3;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)WXButtonClick:(id)sender {
    [self sendWXAuthReq];
}
- (void)sendWXAuthReq{//复制即可
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WXApi sendReq:req];
    }
//    else{
//        //自己简单封装的alert
//        [self showAlertControllerWithTitle:@"温馨提示" withMessage:@"未安装微信应用或版本过低"];
//    }
}

-(void)weiChatOK{//第三方登录:(NSNotification *)notification
//    NSLog(@"我收到微信登录的信息 通知了---%@",[Singleton sharedSingleton].weiXinIfon);
//    NSDictionary *weChatDic = [Singleton sharedSingleton].weiXinIfon;
//    //判断三方登录是否手机认证接口(这里就按照需求走了)
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
//    [parameters setValue:@"3" forKey:@"type"];
//    [parameters setValue:weChatDic[@"openid"] forKey:@"id"];
//    [parameters setValue:weChatDic[@"token"] forKey:@"token"];
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[Singleton sharedSingleton].weiXinIfon mj_JSONString] forKey:@"code"];
    [[HttpRequest sharedInstance] postWithURLString:URL_login_Appialogue parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *DataSoure = [responseObject objectForKey:@"messahe"];
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:[DataSoure objectForKey:@"id"] forKey:User_Mid];
            [defaults setObject:[DataSoure objectForKey:@"type_id"] forKey:User_Type];
            [defaults setObject:[DataSoure objectForKey:@"nickname"] forKey:User_Nickname];
            [Singleton sharedSingleton].nickname = [DataSoure objectForKey:@"nickname"];
            [Singleton sharedSingleton].soleid = [DataSoure objectForKey:@"soleid"];
            [Singleton sharedSingleton].avatar = [DataSoure objectForKey:@"avatar"];
            [Singleton sharedSingleton].type_id = [DataSoure objectForKey:@"type_id"];
            [Singleton sharedSingleton].address = [DataSoure objectForKey:@"address"];
            [Singleton sharedSingleton].audit = [DataSoure objectForKey:@"audit"];
            [Singleton sharedSingleton].Mid = [DataSoure objectForKey:@"id"];
            [Singleton sharedSingleton].balance = [DataSoure objectForKey:@"balance"];
            [Singleton sharedSingleton].phone = [DataSoure objectForKey:@"phone"];
            [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
            [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    NSLog(@"注册成功");
                }
            }];
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (!aError) {
                    NSLog(@"-----------------------------------登录成功");
                    [[EMClient sharedClient] updatePushNotifiationDisplayName:[Singleton sharedSingleton].nickname completion:^(NSString *aDisplayName, EMError *aError) {
                        if (aError) {
                            NSLog(@"-----------------------------------昵称设置成功");
                        }
                    }];
                }
            }];
            [self setJPUSHService];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else {
            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"登录失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiChatOK" object:self];
}
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.PhoneNumber_Field.text forKey:@"phone"];
    [parm setObject:self.Password_Field.text forKey:@"password"];
    [[HttpRequest sharedInstance] postWithURLString:URL_passwordLogin parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *DataSoure = [responseObject objectForKey:@"messahe"];
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:[DataSoure objectForKey:@"id"] forKey:User_Mid];
            [defaults setObject:[DataSoure objectForKey:@"type_id"] forKey:User_Type];
            [defaults setObject:[DataSoure objectForKey:@"nickname"] forKey:User_Nickname];
            [Singleton sharedSingleton].nickname = [DataSoure objectForKey:@"nickname"];
            [Singleton sharedSingleton].soleid = [DataSoure objectForKey:@"soleid"];
            [Singleton sharedSingleton].avatar = [DataSoure objectForKey:@"avatar"];
            [Singleton sharedSingleton].type_id = [DataSoure objectForKey:@"type_id"];
            [Singleton sharedSingleton].address = [DataSoure objectForKey:@"address"];
            [Singleton sharedSingleton].audit = [DataSoure objectForKey:@"audit"];
            [Singleton sharedSingleton].Mid = [DataSoure objectForKey:@"id"];
            [Singleton sharedSingleton].balance = [DataSoure objectForKey:@"balance"];
            [Singleton sharedSingleton].phone = [DataSoure objectForKey:@"phone"];
            [[NSNotificationCenter defaultCenter] postNotificationName:QFC_UpDataSoureToSelfView_NSNotification object:nil];
            [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    NSLog(@"注册成功");
                }
            }];
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (!aError) {
                    NSLog(@"-----------------------------------登录成功");
                    [[EMClient sharedClient] updatePushNotifiationDisplayName:[Singleton sharedSingleton].nickname completion:^(NSString *aDisplayName, EMError *aError) {
                        if (aError) {
                            NSLog(@"-----------------------------------昵称设置成功");
                        }
                    }];
                }
            }];
            [self setJPUSHService];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else {
            [MBProgressHUD py_showError:[responseObject objectForKey:@"message"] toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"登录失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



- (IBAction)GoToHoneViewContraller:(id)sender {
//    self.tabVC = [self setTabBar];
//    self.tabVC.selectedIndex = 0;
//    [self.navigationController presentViewController:self.tabVC animated:YES completion:Nil];
    if (!self.PhoneNumber_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入账号" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if (!self.Password_Field.text.length) {
        [MBProgressHUD py_showError:@"请输入密码" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        [self LoadingDataSoure];
    }
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
    
//    UITabBarItem *item_2 = [contVC.tabBar.items objectAtIndex:1];
    SecondVC.tabBarItem.image = [[UIImage imageNamed:@"icon_ square_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SecondVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_ square_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SecondVC.tabBarItem.title = @"广场";
    
//    UITabBarItem *item_3 = [contVC.tabBar.items objectAtIndex:2];
    ThreeVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Message_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ThreeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Message_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ThreeVC.tabBarItem.title = @"消息";
    
//    UITabBarItem *item_4 = [contVC.tabBar.items objectAtIndex:3];
    FoureVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Mine_Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FoureVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Mine_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FoureVC.tabBarItem.title = @"我的 ";
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:QFC_Color_Green} forState:UIControlStateSelected];
    
    
    QFCTabBar *PublishTabBar = [[QFCTabBar alloc] init];
    [PublishTabBar.plusItem addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [contVC setValue:PublishTabBar forKey:@"tabBar"];
    return contVC;
}

- (void)plusAction:(UIButton *)button {
    XNLog(@"发布");
    Publish_ViewController *pVC = [[Publish_ViewController alloc] init];
    [self.tabVC presentViewController:pVC animated:YES completion:Nil];
}
- (void)setJPUSHService {
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]);
    NSString *alias = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:123];
}

@end
