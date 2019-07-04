//
//  Login_PhoneCodeViewControlloer.m
//  QFC
//
//  Created by tiaoxin on 2019/4/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Login_PhoneCodeViewControlloer.h"

@interface Login_PhoneCodeViewControlloer ()<TencentSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *UserLogin_BT;

@property (nonatomic, strong) UITabBarController *tabVC;
@property (strong, nonatomic) IBOutlet UITextField *Phone_Field;

@property (strong, nonatomic) IBOutlet UIButton *Code_BT;

@property (strong, nonatomic) IBOutlet UITextField *Code_Field;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIButton *AgmentBT;

@property (strong, nonatomic) IBOutlet UIView *Down_View;

@property (strong, nonatomic) IBOutlet UIButton *WX_BT;

@property (strong, nonatomic) IBOutlet UIButton *QQ_BT;

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation Login_PhoneCodeViewControlloer

- (void)viewDidLoad {
    [super viewDidLoad];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfoSuccessed:) name:kGetUserInfoResponse object:nil];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101584572" andDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiChatOK) name:@"weiChatOK" object:NULL];
    if ([WXApi isWXAppInstalled] || [QQApiInterface isQQInstalled]) {
        self.Down_View.hidden = NO;
        if ([WXApi isWXAppInstalled]) {
            self.WX_BT.hidden = NO;
        }else {
            self.WX_BT.hidden = YES;
        }
        if ([QQApiInterface isQQInstalled]) {
            self.QQ_BT.hidden = NO;
        }else {
            self.QQ_BT.hidden = YES;
        }
        
    }else {
        self.Down_View.hidden = YES;
        self.WX_BT.hidden = YES;
        self.QQ_BT.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)AgmentButtonClick:(id)sender {
    self.AgmentBT.selected = !self.AgmentBT.selected;
    if (self.AgmentBT.selected) {
        self.Sure_BT.userInteractionEnabled = YES;
        self.Sure_BT.backgroundColor = QFC_Color_55CC88;
    }else {
        self.Sure_BT.userInteractionEnabled = NO;
        self.Sure_BT.backgroundColor = QFC_Color_D5D5D5;
    }
}

- (IBAction)CodeButtonClick:(id)sender {
    if ([self isPhoneNumber:self.Phone_Field.text]) {
        NSMutableDictionary * parm = [[NSMutableDictionary alloc]init];
        [parm setObject:self.Phone_Field.text forKey:@"phone"];
        
        [[HttpRequest sharedInstance] postWithURLString:URL_note_yunNote parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
            NSLog(@"%@", responseObject);
            if ([[responseObject objectForKey:@"status"] intValue]) {
                [self openCountdown];
                [MBProgressHUD py_showError:@"验证码已发送请注意查收" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7f];
            }else {
                [MBProgressHUD py_showError:@"发送失败" toView:nil];
                [MBProgressHUD setAnimationDelay:0.7f];
            }
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD py_showError:@"发送失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }];
    }
}
- (IBAction)WXButtonClick:(id)sender {
    [self sendWXAuthReq];
}
- (IBAction)QQbuttonClick:(id)sender {
    NSMutableArray *permissions = [[NSMutableArray alloc] initWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    [self.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)tencentDidLogin {
    if (self.tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        [self.tencentOAuth getUserInfo];
        // 记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = _tencentOAuth.accessToken;
    }
    else
    {
//        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}
//用户详细信息
- (void)getUserInfoResponse:(APIResponse *)response {
    NSLog(@"%@", response);
    if (response.message.length) {
        [self PostIndexLoginQqialogue:response.jsonResponse];
    }else {
        [MBProgressHUD py_showError:@"登录失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}


- (IBAction)GotoUserLoginController:(id)sender {
    Login_USer_ViewController *UserVC = [[Login_USer_ViewController alloc] init];
    [self.navigationController pushViewController:UserVC animated:YES];
}
- (IBAction)GotoHomeViewController:(id)sender {
    if ([self isPhoneNumber:self.Phone_Field.text] || self.Code_Field.text.length) {
        [self LoadingDataSoure];
    }
}
- (IBAction)POPToHomeView:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
            [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    NSLog(@"注册成功");
                }
            }];
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
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
    Basic_NavigationController *nav = [[Basic_NavigationController alloc] initWithRootViewController:pVC];
  
    [self.tabVC presentViewController:nav animated:YES completion:Nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:QFC_PublishView_NSNotification object:nil];
}

#pragma 正则匹配手机号

- (BOOL)isPhoneNumber:(NSString *)str {
    if ([str length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"请输入手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}


- (void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //self.VerificationCode_button.siz
                //设置按钮的样式
                [self.Code_BT setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.Code_BT.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.Code_BT setTitle:[NSString stringWithFormat:@"%.2d秒", seconds] forState:UIControlStateNormal];
                self.Code_BT.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}


- (void)LoadingDataSoure {
    /**
     验证码登录
     URL : https://www.txkuaiyou.com/index/Login/noteLogin
     参数 :
     phone
     手机号
     验证码
     验证码
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.Phone_Field.text forKey:@"phone"];
    [parm setObject:self.Code_Field.text forKey:@"note"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Login_noteLogin parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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
            [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    NSLog(@"注册成功");
                }
            }];
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
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
- (void)setJPUSHService {
    NSString *alias = [NSString stringWithFormat:@"%@Ky",[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:123];
}

- (void)PostIndexLoginQqialogue:(NSDictionary *)code {
    /**
     QQ登录
     index/login/Qqialogue
     code
     openid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[code mj_JSONString] forKey:@"code"];
    [parm setObject:self.tencentOAuth.openId forKey:@"openid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Login_Qqialogue parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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
            [[EMClient sharedClient] registerWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    NSLog(@"注册成功");
                }
            }];
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%@Ky", [Singleton sharedSingleton].Mid] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
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

@end
