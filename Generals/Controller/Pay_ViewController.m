
//
//  Pay_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/5/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Pay_ViewController.h"

@interface Pay_ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *Order_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UIView *Apliay_View;

@property (strong, nonatomic) IBOutlet UIView *WXPay_View;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIButton *Apliay_BT;

@property (strong, nonatomic) IBOutlet UIButton *WXPay_BT;

@property (nonatomic, strong) NSDictionary *DataSoure;


@end

@implementation Pay_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlipalyPaySuccess) name:@"AlipalyPaySuccess" object:nil];
    UITapGestureRecognizer *ApliayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ApliayZer:)];
    [self.Apliay_View addGestureRecognizer:ApliayZer];
    
    UITapGestureRecognizer *WXpayZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WXpayZer:)];
    [self.WXPay_View addGestureRecognizer:WXpayZer];
    [self setDataSoureToBacker:self.OrderID];
}

- (IBAction)LiftButtonPOP:(id)sender {
    NSArray * viewControllers  = self.navigationController.viewControllers;
    BOOL YESoRNO = YES;
    for (UIViewController * item in viewControllers) {
        if ([item isKindOfClass:[Home_ShoppingCart_ViewController class]]) {
            [self.navigationController popToViewController:item animated:YES];
            YESoRNO = NO;
            return;
        }
    }
    if (YESoRNO) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)ApliayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = YES;;
    self.WXPay_BT.selected = NO;
}

- (void)WXpayZer:(UIGestureRecognizer *)zer {
    self.Apliay_BT.selected = NO;;
    self.WXPay_BT.selected = YES;
}

- (IBAction)ButtonClick:(id)sender {
    if (self.Apliay_BT.selected) {//支付宝支付
        [self LoadingApliayDataSoure];
    }else {//微信支付
        if (self.Number == 1) {//二次付款
            [self PostIndexWxpayTwoParameter];
        }else {
             [self LoadingDataSoure];
        }
    }
}

- (NSDictionary *)DataSoure {
    if (!_DataSoure) {
        _DataSoure = [[NSDictionary alloc] init];
    }
    return _DataSoure;
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


#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[self.DataSoure objectForKey:@"id"] forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wxpay_parameter parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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

/*
 message = "alipay_sdk=alipay-sdk-php-20180705&app_id=2019042664354132&biz_content=%7B%22body%22%3A%22%5Cu5546%5Cu54c1%5Cu540d%5Cu79f0%22%2C%22subject%22%3A%22%5Cu5546%5Cu54c1%5Cu540d%5Cu79f0%22%2C%22out_trade_no%22%3A%22KY1559108033663%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A0.01%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Fwww.txkuaiyou.com%2Findex%2Falipay%2FaliPayBack&sign_type=RSA2&timestamp=2019-05-29+13%3A33%3A53&version=1.0&sign=FC1a5tPzsGuvaR493BfUzt%2FJgzDHv4TuqhoKjHHL%2FDx4v52S7WCeA5LK0JUEE8Rzp9u1YJoBEtudtUzYd0SYssO1JfXH1r5aMYzkEa8hNdEGrfMWpufpTgHQkTMOmG4QK0qUs7fTvKS8WeLkzxorMgb0NkDcI%2FqUi9fnWl%2FYJBl%2B0s1Flmlfn4FX8qmwQ3eLPU%2FF2bXh96JVYh%2BXJ5qRN8vzPAn7nhxuHAaQT2oawHjO7SP7RRCDjq1Vk4CejsjDpjk58Z%2BGusp%2BGBgLymgFBhGP9XFR7R8CDpFv%2FAh2joU4bD4Zo1EjYNs3K%2FEBwzztWuVcY2HY6nUG2lO%2BbRftuQ%3D%3D";
 status = 1;

 */
- (void)LoadingApliayDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[self.DataSoure objectForKey:@"id"] forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_alipay_alipay parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSString *ApliayString = [responseObject objectForKey:@"message"];
            [self ApliayPay:ApliayString];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
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

- (void)zfbzfcg{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.tag = 2;
    
    [alertView show];
}



- (void)setDataSoureToBacker:(NSString *)orderid {
    self.Sure_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:orderid forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_orders_ordersnFind parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            self.DataSoure = [responseObject objectForKey:@"info"];
            self.Order_Label.text = [NSString stringWithFormat:@"订单号：%@", [self.DataSoure objectForKey:@"ordersn"]];
            self.Price_Label.text = [NSString stringWithFormat:@"¥%@", [self.DataSoure objectForKey:@"price"]];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
        self.Sure_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Sure_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


/**
 index/wxpay/twoParameter
 orderid
 二次付款
 */

- (void)PostIndexWxpayTwoParameter {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[self.DataSoure objectForKey:@"id"] forKey:@"orderid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wxpay_twoParameter parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
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
@end
