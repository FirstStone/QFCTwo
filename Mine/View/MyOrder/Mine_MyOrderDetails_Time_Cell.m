//
//  Mine_MyOrderDetails_Time_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/30.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrderDetails_Time_Cell.h"

@interface Mine_MyOrderDetails_Time_Cell ()
@property (strong, nonatomic) IBOutlet UILabel *OrderNumber_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;


@end

@implementation Mine_MyOrderDetails_Time_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model {
    self.OrderNumber_Label.text = [NSString stringWithFormat:@"订  单  号 ：%@", model.ordersn];
    self.Time_Label.text = [NSString stringWithFormat:@"创建时间：%@", model.createtime];
}


@end
