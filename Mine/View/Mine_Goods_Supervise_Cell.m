//
//  Mine_Goods_Supervise_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Goods_Supervise_Cell.h"

@interface Mine_Goods_Supervise_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UIButton *State_BT;

@property (strong, nonatomic) IBOutlet UIButton *Middle_BT;

@property (strong, nonatomic) IBOutlet UIButton *Dele_BT;

@property (nonatomic, strong) Mine_Goods_Supervise_Model *Mymodel;

@end

@implementation Mine_Goods_Supervise_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_Goods_Supervise_Model *)model {
    self.Mymodel = model;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.Sub_Label.text = [NSString stringWithFormat:@"¥%@元/%@", model.price, model.goods_unit];
    if ([model.status intValue]) {
        [self.State_BT setTitle:@"已上架" forState:UIControlStateNormal];
        [self.Middle_BT setTitle:@"下架" forState:UIControlStateNormal];
    }else {
        [self.State_BT setTitle:@"已下架" forState:UIControlStateNormal];
        [self.Middle_BT setTitle:@"上架" forState:UIControlStateNormal];
    }
    
}
- (IBAction)SetUPButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineGoodsSuperviseCellButtonClick:index:)]) {
        [self.delegate MineGoodsSuperviseCellButtonClick:self.Mymodel index:1];
    }
}

- (IBAction)DeleectButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineGoodsSuperviseCellButtonClick:index:)]) {
        [self.delegate MineGoodsSuperviseCellButtonClick:self.Mymodel index:2];
    }
}


@end
