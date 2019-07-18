//
//  Home_KDR_InvitationViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_InvitationViewController.h"

@interface Home_KDR_InvitationViewController ()

@property (strong, nonatomic) IBOutlet UILabel *Top_Label;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIImageView *ER_imageView;

@property (strong, nonatomic) IBOutlet SDCycleScrollView *sdscrollView;


@end

@implementation Home_KDR_InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self POSTWasteUsersQrcodes];
}

- (void)POSTWasteUsersQrcodes {
    /**
     获取二维码
     waste/users/qrcodes
     uid
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteUsersQrcodes parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            if ([responseObject objectForKey:@"qrcode"]) {
                [self.ER_imageView sd_setImageWithURL:[responseObject objectForKey:@"qrcode"]];
            }
            if ([[responseObject objectForKey:@"type"] intValue]) {
                self.Sure_BT.hidden = NO;
                self.Top_Label.text = @"您有一个卡包待领取";
            }else {
                self.Sure_BT.hidden = YES;
                self.Top_Label.text = @"分享二维码，成功入驻可得120元代扔年卡";
            }
//            NSArray *Array = [responseObject objectForKey:@"list"];
//            [self.hotTopArray removeAllObjects];
//            for (NSString *HotStr in Array) {
//                [self.hotTopArray addObject:HotStr];
//            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}



@end
