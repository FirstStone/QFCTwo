//
//  Mine_MyOrderDetails_Statistics_New_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrderDetails_Statistics_New_Cell.h"

@interface Mine_MyOrderDetails_Statistics_New_Cell ()

@property (strong, nonatomic) IBOutlet UILabel *Lift1_Label;

@property (strong, nonatomic) IBOutlet UILabel *Lift2_Label;

@property (strong, nonatomic) IBOutlet UILabel *Lift3_Label;

@property (strong, nonatomic) IBOutlet UILabel *Lift4_Label;

@property (strong, nonatomic) IBOutlet UILabel *Right1_Lable;

@property (strong, nonatomic) IBOutlet UILabel *Right2_Label;

@property (strong, nonatomic) IBOutlet UILabel *Right3_Label;

@property (strong, nonatomic) IBOutlet UILabel *Right4_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sum_Lable;

@property (strong, nonatomic) IBOutlet UILabel *Price_Label;



@end

@implementation Mine_MyOrderDetails_Statistics_New_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMineOrderDetailsModelToCell:(Mine_Order_Details_Model *)model {
    if ([model.type intValue] == 3) {//商家
        self.Lift1_Label.text = @"配送方式：";
        self.Right1_Lable.text = [model.merchant_errand intValue] == 1 ? @"配送" : @"自取";
        
        self.Lift2_Label.text = @"取货地址：";
        self.Right2_Label.textColor = QFC_Color_Six;
        self.Right2_Label.text = model.finish_address;
        
        self.Lift3_Label.text = @"优惠：";
        self.Right3_Label.text = [NSString stringWithFormat:@"¥%0.2f", ([model.sum_price doubleValue] - [model.actual_price doubleValue])];
        
        self.Lift4_Label.text = @"备注：";
        self.Right4_Label.text = model.remark;
        
        self.Sum_Lable.text = [NSString stringWithFormat:@"共%lu件  小计：¥%@", (unsigned long)model.goodslist.count, model.sum_price];
        
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"已优惠："];
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, noteStr.length)];
        // 改变颜色
        NSMutableAttributedString * redStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%0.2f  ", ([model.sum_price doubleValue] - [model.actual_price doubleValue])]];
        [redStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, redStr1.length)];
        
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"实付："];
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, noteStr2.length)];
        // 改变颜色
        NSMutableAttributedString * redStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.actual_price]];
        [redStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, redStr2.length)];
        
        
        [noteStr appendAttributedString:redStr1];
        [noteStr appendAttributedString:noteStr2];
        [noteStr appendAttributedString:redStr2];
        
        
        [self.Price_Label setAttributedText:noteStr];
//        self.Price_Label.text = [NSString stringWithFormat:@"已优惠¥%0.2f 实付：¥%@", ([model.sum_price doubleValue] - [model.actual_price doubleValue]), model.actual_price];
        
    }else if ([model.type intValue] == 1) {//跑腿
        self.Lift1_Label.text = @"物品重量：";
        self.Right1_Lable.text = model.weight;
        
        self.Lift2_Label.text = @"取 货 码：";
        self.Right2_Label.textColor = QFC_Color_30AC65;
        self.Right2_Label.text = model.parcel_pw;
        
        self.Lift3_Label.text = @"预约费用：";
        self.Right3_Label.text = [NSString stringWithFormat:@"%@元", model.press_price];
        
        self.Lift4_Label.text = @"备注：";
        self.Right4_Label.text = model.remark;
        
        self.Sum_Lable.hidden = YES;
        self.Price_Label.hidden = YES;
        
    }else {//家政
        self.Lift1_Label.text = @"服务地址：";
        self.Right1_Lable.text = model.finish_address;
        
        self.Lift2_Label.text = @"服务时间：";
        self.Right2_Label.textColor = QFC_Color_Six;
        self.Right2_Label.text = model.createtime;
        
        self.Lift3_Label.text = @"家政费用：";
        self.Right3_Label.text = [NSString stringWithFormat:@"%@元", model.actual_price];
        
        self.Lift4_Label.text = @"备注：";
        self.Right4_Label.text = model.remark;
        
        self.Sum_Lable.hidden = YES;
        self.Price_Label.hidden = YES;
        
    }
}


@end
