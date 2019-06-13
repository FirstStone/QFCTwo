//
//  Mine_MyCardView_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyCardView_Cell.h"

@interface Mine_MyCardView_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *State_Label;

@property (strong, nonatomic) IBOutlet UILabel *Limit_Label;

@property (strong, nonatomic) IBOutlet UILabel *Number_Label;

@property (strong, nonatomic) IBOutlet UILabel *Tip_Label;

@property (strong, nonatomic) IBOutlet UIButton *Delect_BT;

@property (nonatomic, strong) Mine_MyCard_Model *MyModel;

@end

@implementation Mine_MyCardView_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)DelectButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineMyCardViewCellButtonClick:)]) {
        [self.delegate MineMyCardViewCellButtonClick:self.MyModel];
    }
}


- (void)setModelToCell:(Mine_MyCard_Model *)model {
    self.MyModel = model;
    self.Tip_Label.text = [NSString stringWithFormat:@"有效时间：%@-%@  %@", model.begintime, model.endtime, [model.status intValue] == 1 ? @"（正常发放）" : ([model.status intValue] == 2 ? @"（发放完毕）" : @"（结束发放）")];
    self.Limit_Label.text = [model.type intValue] == 1 ? @"  全店可用  " : @"  指定商品可用  ";
    self.State_Label.text = [model.type intValue] == 1 ? @"  进店  " : @"  线上  ";
    self.Number_Label.text = [NSString stringWithFormat:@"剩余%@张", model.repertory];
    if ([model.discount_status intValue] == 1) {//满减
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"¥"];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:model.minusprice];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  满%@元使用", model.fullprice]];
        [noteStr appendAttributedString:redStr];
        [noteStr appendAttributedString:noteStr1];
        
        [self.Title_Label setAttributedText:noteStr];
        
    }else if ([model.discount_status intValue] == 2) {//折扣
        
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1f",[model.discount floatValue]/10.0f]];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:@"折  优惠"];
        
        [redStr appendAttributedString:noteStr1];
        
        [self.Title_Label setAttributedText:redStr];
        
        
    }else {//代金券
        self.Title_Label.text = [NSString stringWithFormat:@"购买立减%@元", model.discount];
    }
}

- (void)setUserModelToCell:(Mine_MyCard_Model *)model {
    self.MyModel = model;
    self.Tip_Label.text = [NSString stringWithFormat:@"有效时间：%@-%@", model.begintime, model.endtime];
    self.Limit_Label.text = [model.type intValue] == 1 ? [NSString stringWithFormat:@"  %@全店可用  ", model.merchant] : [NSString stringWithFormat:@"  %@指定商品可用  ", model.merchant];
    self.State_Label.text = [model.type intValue] == 1 ? @"  进店  " : @"  线上  ";
    self.Number_Label.hidden = YES;
    [self.Delect_BT setTitle:@"立即使用" forState:UIControlStateNormal];
    if ([model.discount_status intValue] == 1) {//满减
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"¥"];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:model.minusprice];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  满%@元使用", model.fullprice]];
        [noteStr appendAttributedString:redStr];
        [noteStr appendAttributedString:noteStr1];
        
        [self.Title_Label setAttributedText:noteStr];
        
    }else if ([model.discount_status intValue] == 2) {//折扣
        
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1f",[model.discount floatValue]/10.0f]];
        // 改变字体大小及类型
        [redStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f weight:UIFontWeightBold] range:NSMakeRange(0, redStr.length)];
        
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:@"折  优惠"];
        
        [redStr appendAttributedString:noteStr1];
        
        [self.Title_Label setAttributedText:redStr];
        
        
    }else {//代金券
        self.Title_Label.text = [NSString stringWithFormat:@"购买立减%@元", model.discount];
    }
}

@end
