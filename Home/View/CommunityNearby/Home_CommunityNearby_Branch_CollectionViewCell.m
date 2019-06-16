//
//  Home_CommunityNearby_Branch_CollectionViewCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Branch_CollectionViewCell.h"

@interface Home_CommunityNearby_Branch_CollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;
@property (strong, nonatomic) IBOutlet UILabel *Price_Label;
@property (strong, nonatomic) IBOutlet UILabel *Distance_Label;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (nonatomic, strong) Home_CommunityNearby_ActivityBranch_Model *MyModel;

@end

@implementation Home_CommunityNearby_Branch_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModelToCell:(Home_CommunityNearby_ActivityBranch_Model *)model {
    self.MyModel = model;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@/%@", model.price, model.goods_unit];
    if (model.times.length) {
        self.Time_Label.hidden = NO;
        self.Time_Label.text = [NSString stringWithFormat:@"  %@  ", model.times];
    }
    if (model.distance.length) {
        self.Distance_Label.hidden = NO;
        self.Distance_Label.text = [NSString stringWithFormat:@"  %@  ", model.distance];
    }
}

- (IBAction)ShopCartButtonClick:(id)sender {
    [self LoadingDataSoure];
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     加入购物车
     URL : https://www.txkuaiyou.com/index/Shoppings/shoppingAdd
     参数 :
     uid
     用户ID
     goodsid
     商品ID
     sum
     数量
     specification
     规格   红xl  用空格隔开
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.MyModel.Branch_id forKey:@"goodsid"];
    [parm setObject:@"1" forKey:@"sum"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Shoppings_shoppingAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
         if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showSuccess:@"添加成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }else {
            [MBProgressHUD py_showSuccess:@"操作失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showSuccess:@"请求失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
