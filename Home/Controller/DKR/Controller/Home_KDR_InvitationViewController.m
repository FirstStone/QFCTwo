//
//  Home_KDR_InvitationViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/7/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDR_InvitationViewController.h"

@interface Home_KDR_InvitationViewController ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *Top_Label;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (strong, nonatomic) IBOutlet UIImageView *ER_imageView;

@property (strong, nonatomic) IBOutlet UIImageView *ContView;

@property (nonatomic, strong) SDCycleScrollView *sdcyscrollview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation Home_KDR_InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ContView addSubview:self.sdcyscrollview];
    [self.sdcyscrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ContView.mas_left).offset(70.0f);
        make.right.equalTo(self.ContView.mas_right).offset(-70.0f);
        make.height.offset(70.0f);
        make.centerX.equalTo(self.ER_imageView.mas_centerX);
        make.top.equalTo(self.ER_imageView.mas_bottom).offset(40.0f);
    }];
    [self.ContView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sdcyscrollview.mas_bottom).offset(10.0f);
    }];
    [self POSTWasteUsersQrcodes];
    [self POSTWasteUsersInvite];
}

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (SDCycleScrollView *)sdcyscrollview {
    if (!_sdcyscrollview) {
        _sdcyscrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectNull delegate:self placeholderImage:nil];
        _sdcyscrollview.scrollDirection = UICollectionViewScrollDirectionVertical;
        _sdcyscrollview.showPageControl = NO;
        
    }
    return _sdcyscrollview;
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
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
    
}


- (void)POSTWasteUsersInvite {
    /**
     获取列表
     waste/users/invite
     uid
     page
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_wasteUsersInvite parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_KDR_YQList_Model *model = [Home_KDR_YQList_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
                [self.titleArray addObject:model.nickname];
                [self.imageArray addObject:model.avatar];
            }
            self.sdcyscrollview.imageURLStringsGroup = self.imageArray;
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"获取失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view {
    return [UINib nibWithNibName:NSStringFromClass([Home_KDR_SD_CollectionViewCell class]) bundle:[NSBundle mainBundle]];
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    Home_KDR_SD_CollectionViewCell *Cell = (Home_KDR_SD_CollectionViewCell *)cell;
    Home_KDR_YQList_Model *model = self.dataArray[index];
    if (model.avatar.length) {
        [Cell.icon_View sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    Cell.Name_Label.text = model.nickname;
    Cell.Time_Label.text = model.createtime;
}

@end
