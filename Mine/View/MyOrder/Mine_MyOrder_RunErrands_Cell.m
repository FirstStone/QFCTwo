//
//  Mine_MyOrder_RunErrands_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_RunErrands_Cell.h"

@interface Mine_MyOrder_RunErrands_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *TakeAddress_Label;

@property (strong, nonatomic) IBOutlet UILabel *TakePeople_Label;

@property (strong, nonatomic) IBOutlet UILabel *ClosedAddress_Label;

@property (strong, nonatomic) IBOutlet UILabel *ClosedPeople_Label;

@end

@implementation Mine_MyOrder_RunErrands_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setModelToCell:(Mine_Order_Model *)model {
    self.TakePeople_Label.text = model.begin_address;
    self.TakePeople_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号%@", model.begin_realname, model.begin_phone];
    self.ClosedAddress_Label.text = model.finish_address;
    self.ClosedPeople_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号%@", model.finish_realname, model.finish_phone];
}

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model {
    self.TakePeople_Label.text = model.begin_address;
    self.TakePeople_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号%@", model.begin_realname, model.begin_phone];
    self.ClosedAddress_Label.text = model.finish_address;
    self.ClosedPeople_Label.text = [NSString stringWithFormat:@"寄件人：%@\n手机号%@", model.finish_realname, model.finish_phone];
}

@end
