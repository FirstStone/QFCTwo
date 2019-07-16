//
//  Mine_SetUP_MyAddress_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_MyAddress_Cell.h"

@interface Mine_SetUP_MyAddress_Cell ()

@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;

@end

@implementation Mine_SetUP_MyAddress_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 "address": "上海市",
 "details": "上海市",
 "id": 10,
 "realname": "真名",
 "phone": "123456789",
 "sex": 1
 */

- (void)setModelToCell:(Mine_SetUP_MyAddress_Model *)model {
    self.My_Model = model;
    if ([model.latitude doubleValue] && [model.longitude doubleValue]) {
        self.Name_Label.text = model.realname;
        self.Phone_Label.text = model.phone;
        self.Address_Label.text = [NSString stringWithFormat:@"%@%@%@%@", model.city ,model.county, model.village, model.details];
        self.Default_BT.selected = [model.status intValue];
    }else {
        self.Name_Label.text = model.realname;
        self.Phone_Label.text = model.phone;
        self.Address_Label.text = [NSString stringWithFormat:@"%@%@", model.address, model.details];
        self.Default_BT.selected = [model.status intValue];
    }
    
}

- (IBAction)DelectBTClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineSetUPMyAddressCellDelectButtonClick:button:)]) {
        [self.delegate MineSetUPMyAddressCellDelectButtonClick:self.My_Model button:self.Delect_BT];
    }
}


- (IBAction)EditBTClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineSetUPMyAddressCellEditButtonClick:button:)]) {
        [self.delegate MineSetUPMyAddressCellEditButtonClick:self.My_Model button:self.Edit_BT];
    }
}

- (IBAction)DefaultBTClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineSetUPMyAddressCellDefaltButtonClick:button:)]) {
        [self.delegate MineSetUPMyAddressCellDefaltButtonClick:self.My_Model button:self.Default_BT];
    }
    
}


@end
