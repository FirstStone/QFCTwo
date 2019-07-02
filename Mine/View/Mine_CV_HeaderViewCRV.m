//
//  Mine_CV_HeaderViewCRV.m
//  QFC
//
//  Created by tiaoxin on 2019/4/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_CV_HeaderViewCRV.h"

@interface Mine_CV_HeaderViewCRV ()
@property (strong, nonatomic) IBOutlet UILabel *Follow_Label;
@property (strong, nonatomic) IBOutlet UILabel *Publish_Label;
@property (strong, nonatomic) IBOutlet UILabel *Collection_Label;
@property (strong, nonatomic) IBOutlet UILabel *Balance_Label;
@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Label;
@property (strong, nonatomic) IBOutlet UILabel *UserID_Label;
@property (strong, nonatomic) IBOutlet UIButton *ShopState_BT;


@end

@implementation Mine_CV_HeaderViewCRV

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataSoureToSelf) name:QFC_UpDataSoureToSelfView_NSNotification object:nil];
    [self.Follow_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FollowLableClick:)]];
    [self.Publish_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PublishLabelClick:)]];
    [self.Collection_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CollectionLabelClick:)]];
    [self.Balance_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(balanceLabelClick:)]];
    [self.Photo_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotoImageViewClick:)]];
    [self.Name_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhotoImageViewClick:)]];
    [self.UserID_Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhotoImageViewClick:)]];
    
}
/**
 //    [self.ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
 //        make.edges.equalTo(self).insets(UIEdgeInsetsMake(30, 30, 30, 30));
 //    }];
 //    [self layoutSubviews];
 //    [self setNeedsLayout];
 
 //        CAGradientLayer *layer = [CAGradientLayer layer];
 //        layer.startPoint = CGPointMake(0, 0);
 //        layer.endPoint = CGPointMake(1, 1);
 //        layer.colors = [NSArray arrayWithObjects:(__bridge id)QFC_Color(85,204,136).CGColor,(__bridge id)QFC_Color(48,172,101).CGColor, nil];
 //        //    layer.locations = @[@0.0f,@0.6f,@1.0f];
 //        layer.frame = self.ContentView.bounds;
 //        [self.ContentView.layer insertSublayer:layer atIndex:0];
 //    layer.name = @"gradientLayer";
 //    UIGraphicsBeginImageContextWithOptions(self.ContentView.bounds.size, self.ContentView.opaque, 0.0);
 //    [layer renderInContext:UIGraphicsGetCurrentContext()];
 //    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
 //    UIGraphicsEndImageContext();
 //    self.ContentView.backgroundColor = [UIColor colorWithPatternImage:img];
 */

#pragma mark----Click
- (void)FollowLableClick:(UIGestureRecognizer *)Zer {//关注
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Mine_FollowViewController *followVC = [[Mine_FollowViewController alloc] init];
        [followVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:followVC animated:YES];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)PublishLabelClick:(UIGestureRecognizer *)Zer {//发布
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Mine_PublishViewController *publishVC = [[Mine_PublishViewController alloc] init];
        [publishVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:publishVC animated:YES];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}
- (void)CollectionLabelClick:(UITapGestureRecognizer *)Zer {//收藏
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Mine_CollectionViewController *conllectionVC = [[Mine_CollectionViewController alloc] init];
        [conllectionVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:conllectionVC animated:YES];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
    
}

- (void)PhotoImageViewClick:(UITapGestureRecognizer *)Zer {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Square_Prsonal_Details_VC *personalVC = [[Square_Prsonal_Details_VC alloc] init];
        personalVC.uid = [[NSUserDefaults standardUserDefaults] objectForKey:User_Mid];
        [personalVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:personalVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (IBAction)SetUPButtonClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Mine_SetUP_ViewController *setupVC = [[Mine_SetUP_ViewController alloc] init];
        [setupVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:setupVC animated:YES];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}
- (IBAction)StateBTClick:(id)sender {
    self.ShopState_BT.selected = !self.ShopState_BT.selected;
}

- (IBAction)QRCoderButtonClick:(id)sender {
    QRCodeViewController *QrcodeVC = [[QRCodeViewController alloc] init];
    self.My_NVC.navigationBarHidden = NO;
    [QrcodeVC setHidesBottomBarWhenPushed:YES];
    [self.My_NVC pushViewController:QrcodeVC animated:YES];
}



- (void)balanceLabelClick:(UITapGestureRecognizer *)Zer {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Mine_WalletViewController *walletVC = [[Mine_WalletViewController alloc] init];
        [walletVC setHidesBottomBarWhenPushed:YES];
        [self.My_NVC pushViewController:walletVC animated:YES];
    } else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.My_NVC presentViewController:LoginVC animated:YES completion:Nil];
    }
}


- (void)upDataSoureToSelf {
    NSLog(@"%@", [Singleton sharedSingleton].avatar);
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Type] intValue] == 0) {
//            self.ShopState_BT.hidden = YES;
//        } else {
//            self.ShopState_BT.hidden = NO;
//        }
//    }else {
//        self.ShopState_BT.hidden = YES;
//    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:[Singleton sharedSingleton].avatar]];
        self.Name_Label.text = [NSString stringWithFormat:@"%@",[Singleton sharedSingleton].nickname];
        self.UserID_Label.text = [NSString stringWithFormat:@"ID:%@",[Singleton sharedSingleton].soleid];
        self.Follow_Label.text = [NSString stringWithFormat:@"关注\n%@", [Singleton sharedSingleton].attention_sum];
        self.Publish_Label.text = [NSString stringWithFormat:@"发布\n%@", [Singleton sharedSingleton].plaza_sum];
        self.Collection_Label.text = [NSString stringWithFormat:@"收藏\n%@", [Singleton sharedSingleton].collect_sum];
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"\n账户余额(¥)"];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f weight:UIFontWeightMedium] range:NSMakeRange(0, noteStr.length)];
        [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[Singleton sharedSingleton].balance];
        [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_30AC65 range:NSMakeRange(0, redStr.length)];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        // 为label添加Attribute
        [redStr appendAttributedString:noteStr];
        [self.Balance_Label setAttributedText:redStr];
        
    } else {
        self.Photo_imageView.image = [UIImage imageNamed:@"icon_touxiang"];
        self.Name_Label.text = @"未登录";
        self.UserID_Label.text = @"ID:00000000";
        self.Follow_Label.text = @"关注\n0";
        self.Publish_Label.text = @"发布\n0";
        self.Collection_Label.text = @"收藏\n0";
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"\n账户余额(¥)"];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f weight:UIFontWeightMedium] range:NSMakeRange(0, noteStr.length)];
        [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:@"00.00"];
        [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_30AC65 range:NSMakeRange(0, redStr.length)];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        // 为label添加Attribute
        [redStr appendAttributedString:noteStr];
        [self.Balance_Label setAttributedText:redStr];
    }
}
@end
