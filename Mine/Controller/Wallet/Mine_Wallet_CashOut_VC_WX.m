//
//  Mine_Wallet_CashOut_VC_WX.m
//  QFC
//
//  Created by tiaoxin on 2019/7/1.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_CashOut_VC_WX.h"

@interface Mine_Wallet_CashOut_VC_WX ()
@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UIView *Top_View;

@property (strong, nonatomic) IBOutlet UITextField *Money_Field;

@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;


@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@end

@implementation Mine_Wallet_CashOut_VC_WX

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiChatOK) name:@"weiChatOK" object:NULL];
    self.Tip_Label.text = [NSString stringWithFormat:@"可提现金额%@元",self.Balance];
    UITapGestureRecognizer *TapViewZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TopViewChange:)];
    [self.Top_View addGestureRecognizer:TapViewZer];
}

- (IBAction)SureButtonClick:(id)sender {
    NSString *balace = [NSString stringWithFormat:@"%0.2lf",[self.Money_Field.text doubleValue]];
    if ([balace doubleValue] > [self.Balance doubleValue] || [self.Balance doubleValue] == 0) {
        [MBProgressHUD py_showError:@"余额不足" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else if(![balace doubleValue]) {
        [MBProgressHUD py_showError:@"请输入金额" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }else {
        NSDictionary *WXDic = [Singleton sharedSingleton].weiXinIfon;
        if (WXDic) {
            [self PostIndexWxpayPayToUser:[WXDic objectForKey:@"openid"]];
        }
    }
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)TopViewChange:(UIGestureRecognizer *)zer {
    [self sendWXAuthReq];
}

- (void)sendWXAuthReq{//复制即可
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WXApi sendReq:req];
    }else {
        [MBProgressHUD py_showError:@"抱歉，您不能进行提现操作" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}

#pragma mark----UPdata
- (void)PostIndexWxpayPayToUser:(NSString *)openid{
    /**
     微信余额提现
     URL : https://www.txkuaiyou.com/index/wxpay/payToUser
     参数 :
     uid
     用户ID
     price
     提现金额
     openid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Money_Field.text forKey:@"price"];
    [parm setObject:openid forKey:@"openid"];
    self.Sure_BT.userInteractionEnabled = YES;
    [[HttpRequest sharedInstance] postWithURLString:URL_wxpay_payToUser parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.Sure_BT.userInteractionEnabled = NO;
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"提现成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD py_showSuccess:@"提现失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = NO;
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



-(void)weiChatOK{
    NSLog(@"%@", [Singleton sharedSingleton].weiXinIfon);
    //    NSLog(@"我收到微信登录的信息 通知了---%@",[Singleton sharedSingleton].weiXinIfon);
    //    NSDictionary *weChatDic = [Singleton sharedSingleton].weiXinIfon;
    //    //判断三方登录是否手机认证接口(这里就按照需求走了)
    //    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    //    [parameters setValue:@"3" forKey:@"type"];
    //    [parameters setValue:weChatDic[@"openid"] forKey:@"id"];
    //    [parameters setValue:weChatDic[@"token"] forKey:@"token"];
//    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
//    [parm setObject:[[Singleton sharedSingleton].weiXinIfon mj_JSONString] forKey:@"code"];
//    [[HttpRequest sharedInstance] postWithURLString:URL_login_Appialogue parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
//        NSLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] intValue]) {
//
//    } failure:^(NSError * _Nonnull error) {
//        [MBProgressHUD py_showError:@"授权失败" toView:nil];
//        [MBProgressHUD setAnimationDelay:0.7f];
//    }];
    NSDictionary *WXDic = [Singleton sharedSingleton].weiXinIfon;
    if (WXDic) {
        self.Text_Label.text = [WXDic objectForKey:@"nickname"];
    }
}

@end
