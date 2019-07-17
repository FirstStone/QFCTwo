//
//  Home_KDROrder_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_KDROrder_Cell.h"

@interface Home_KDROrder_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Address_Label;

@property (strong, nonatomic) IBOutlet UILabel *Peopel_Label;

@property (strong, nonatomic) IBOutlet UIButton *State_BT;


@end

@implementation Home_KDROrder_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToCell:(Home_KDR_Order_Model *)model {
    self.Time_Label.text = model.createtime;
    self.Address_Label.text = [NSString stringWithFormat:@"%@%@", model.village, model.details];
    self.Peopel_Label.text = [NSString stringWithFormat:@"姓名：%@\n电话：%@",model.realname, model.phone];
    switch ([model.status intValue]) {
        case 0://代接单
        {
            [self.State_BT setTitle:@"  待接单  " forState:UIControlStateNormal];
        }
            break;
        case 1://代完成
        {
            [self.State_BT setTitle:@"  待完成  " forState:UIControlStateNormal];
        }
            break;
        case 2://确认完成
        {
            [self.State_BT setTitle:@"  确认完成  " forState:UIControlStateNormal];
        }
            break;
        case 3://已完成
        {
            [self.State_BT setTitle:@"  已完成  " forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}



@end
