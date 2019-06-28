//
//  Mine_Wallet_Recharge_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Wallet_Recharge_ViewController.h"

@interface Mine_Wallet_Recharge_ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *Price_Label;

@property (strong, nonatomic) IBOutlet UIView *Apliay_View;

@property (strong, nonatomic) IBOutlet UIView *WXPay_View;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIButton *Apliay_BT;

@property (strong, nonatomic) IBOutlet UIButton *WXPay_BT;

@end

@implementation Mine_Wallet_Recharge_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlipalyPaySuccess) name:@"AlipalyPaySuccess" object:nil];
    UITapGestureRecognizer *ApliayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ApliayZer:)];
    [self.Apliay_View addGestureRecognizer:ApliayZer];
    UITapGestureRecognizer *WXpayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WXpayZer:)];
    [self.WXPay_View addGestureRecognizer:WXpayZer];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ApliayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = YES;;
    self.WXPay_BT.selected = NO;
}

- (void)WXpayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = NO;;
    self.WXPay_BT.selected = YES;
}

- (IBAction)SureButtonClick:(id)sender {
    if (self.Apliay_BT.selected) {
        [self PostindexAlipayCharge];
    }else {
        [self PostindexWxpayChargeParameter];
    }
}

#pragma mark----UPdata

- (void)PostindexWxpayChargeParameter {
    /**
     APP微信充值余额获取签名信息
     URL : https://www.txkuaiyou.com/index/wxpay/chargeParameter
     参数 :
     uid
     用户ID
     price
     充值金额
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Price_Label.text forKey:@"price"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wxpay_chargeParameter parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSDictionary *dic = [responseObject objectForKey:@"info"];
            [self wxpay:[dic objectForKey:@"partnerid"] prepayid:[dic objectForKey:@"prepayid"] package:[dic objectForKey:@"package"] noncestr:[dic objectForKey:@"noncestr"] timestamp:[dic objectForKey:@"timestamp"] sign:[dic objectForKey:@"sign"]];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}

- (void)wxpay:(NSString *)partnerid prepayid:(NSString *)prepayid package:(NSString*)package noncestr:(NSString *)noncestr timestamp:(NSString *)timestamp sign:(NSString *)sign {
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepayid;
    request.package = package;
    request.nonceStr= noncestr;
    request.timeStamp = [timestamp intValue];
    request.sign= sign;
    [WXApi sendReq:request];
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                [self AlipalyPaySuccess];
                //                [self getWKPjudgeIsByBestCouponData];
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}

- (void)PostindexAlipayCharge {
    /**
     APP支付宝充值余额
     URL : https://www.txkuaiyou.com/index/alipay/charge
     参数 :
     uid
     用户ID
     price
     充值金额
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Price_Label.text forKey:@"price"];
    [[HttpRequest sharedInstance] postWithURLString:URL_alipay_charge parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
         if ([[responseObject objectForKey:@"status"] intValue]) {
             NSString *ApliayString = [responseObject objectForKey:@"message"];
             [self ApliayPay:ApliayString];
         }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)ApliayPay:(NSString *)SearchStr {
    [[AlipaySDK defaultService] payOrder:SearchStr fromScheme:@"QFC" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        NSString *subTitle = @"";
        NSString *resultStatus = resultDic[@"resultStatus"];
        switch ([resultStatus intValue]) {
            case 9000:
                subTitle = @"支付成功";
                [self AlipalyPaySuccess];
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
    }];
}

- (void)AlipalyPaySuccess {
    [MBProgressHUD py_showError:@"支付成功" toView:nil];
    [MBProgressHUD setAnimationDelay:0.7f];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabelViewBeginDataSoure" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
