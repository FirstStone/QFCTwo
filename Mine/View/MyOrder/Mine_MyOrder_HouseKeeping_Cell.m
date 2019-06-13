//
//  Mine_MyOrder_HouseKeeping_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_HouseKeeping_Cell.h"

@interface Mine_MyOrder_HouseKeeping_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UILabel *People_Label;

@end

@implementation Mine_MyOrder_HouseKeeping_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_Order_Model *)model {
    self.Title_Label.text = [NSString stringWithFormat:@"%@-%@", [model.hyusbandry_type intValue] == 1 ? @"日常保洁" : @"深度保洁", model.weight];
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
    self.People_Label.text = [NSString stringWithFormat:@"服务方姓名：%@\n联系方式：%@\n服务地址：%@",model.finish_realname, model.finish_phone, model.finish_address];
    self.Time_Label.text = model.createtime;
}

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model {
    self.Title_Label.text = [NSString stringWithFormat:@"%@-%@", [model.hyusbandry_type intValue] == 1 ? @"日常保洁" : @"深度保洁", model.weight];
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.price];
//    self.People_Label.text = [NSString stringWithFormat:@"服务方姓名：%@\n联系方式：%@\n服务地址：%@",model.finish_realname, model.finish_phone, model.finish_address];
    self.Time_Label.text = model.createtime;
    [self.People_Label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.0f);
    }];
    self.People_Label.hidden = YES;
}

@end
