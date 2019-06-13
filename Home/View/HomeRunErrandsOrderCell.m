//
//  HomeRunErrandsOrderCell.m
//  QFC
//
//  Created by tiaoxin on 2019/5/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HomeRunErrandsOrderCell.h"

@interface HomeRunErrandsOrderCell ()

@property (strong, nonatomic) IBOutlet UIButton *States_BT;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UIButton *Edit_BT;

@property (strong, nonatomic) IBOutlet UIButton *Delect_BT;




@property (nonatomic, strong) Mine_SetUP_MyAddress_Model *My_Model;


@end

@implementation HomeRunErrandsOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)EditButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeRunErrandsOrderCellEditButtonClick:button:)]) {
        [self.delegate HomeRunErrandsOrderCellEditButtonClick:self.My_Model button:self.Edit_BT];
    }
}

- (IBAction)DelectButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HomeRunErrandsOrderCellDelectButtonClick:button:)]) {
        [self.delegate HomeRunErrandsOrderCellDelectButtonClick:self.My_Model button:self.Delect_BT];
    }
}

- (void)setModelToCell:(Mine_SetUP_MyAddress_Model *)model {
    self.My_Model = model;
    [self awakeFromNib];
    self.States_BT.selected = [model.status intValue];
    self.Text_Label.text = [NSString stringWithFormat:@"%@%@", model.address, model.details];
}


@end
