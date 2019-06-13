//
//  Mine_MyActivity_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyActivity_Cell.h"

@interface Mine_MyActivity_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *YuanJia_Label;

@property (strong, nonatomic) IBOutlet UILabel *Xianjia_Label;

@property (strong, nonatomic) IBOutlet UILabel *Ratio_Label;


@end

@implementation Mine_MyActivity_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_MyActivity_Branch_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    self.Title_Label.text = model.goods_name;
    self.YuanJia_Label.text = [NSString stringWithFormat:@"原价：¥%@", model.price];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"现价："];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.activity_price]];
    [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, redStr.length)];
    [noteStr appendAttributedString:redStr];
    [self.Xianjia_Label setAttributedText:noteStr];
    
    self.Ratio_Label.text = [NSString stringWithFormat:@"%@%%", model.discount];
}

@end
