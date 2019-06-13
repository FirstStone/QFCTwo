//
//  Message_RunErrands_TableView_NoOrderCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_RunErrands_TableView_NoOrderCell.h"

@interface Message_RunErrands_TableView_NoOrderCell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *OrderNumber_Label;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;

@property (strong, nonatomic) IBOutlet UILabel *Begin_Label;

@property (strong, nonatomic) IBOutlet UILabel *BeginPeoPle_Label;

@property (strong, nonatomic) IBOutlet UILabel *End_Label;

@property (strong, nonatomic) IBOutlet UILabel *EndPeoPle_Label;

@property (strong, nonatomic) IBOutlet UIButton *Right_BT;

@property (nonatomic, strong) Message_RunErrands_Model *MyModel;


@end

@implementation Message_RunErrands_TableView_NoOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SureButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MessageRunErrandsTableViewNoOrderCellButtonClick:)]) {
        [self.delegate MessageRunErrandsTableViewNoOrderCellButtonClick:self.MyModel];
    }
}


- (void)setDataSoureToCell:(Message_RunErrands_Model *)model index:(NSInteger)index {
    self.MyModel = model;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.OrderNumber_Label.text = [NSString stringWithFormat:@"订单号：%@", model.ordersn];
    self.Price_Label.text = [NSString stringWithFormat:@"¥%@", model.press_price];
    self.Begin_Label.text = model.begin_address;
    self.BeginPeoPle_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号：%@", model.begin_realname, model.begin_phone];
    self.End_Label.text = model.finish_address;
    self.EndPeoPle_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号：%@", model.finish_realname, model.finish_phone];
    if (index) {
        if ([model.type intValue] == 1) {
            if ([model.status intValue] == 2) {
                [self.Right_BT setTitle:@"立即取货" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 3) {
                self.Right_BT.userInteractionEnabled = NO;
                [self.Right_BT setTitle:@"等待付款用户二次付款" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 4) {
                [self.Right_BT setTitle:@"确认送达" forState:UIControlStateNormal];
            }
        }else if ([model.type intValue] == 3){
            if ([model.status intValue] == 3) {
                [self.Right_BT setTitle:@"确认取货" forState:UIControlStateNormal];
            }else if ([model.status intValue] == 4) {
                [self.Right_BT setTitle:@"确认送达" forState:UIControlStateNormal];
            }
        }
    }else {
        [self.Right_BT setTitle:@"立即接单" forState:UIControlStateNormal];
    }
}

@end
