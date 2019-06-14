//
//  Mine_MyOrder_AllEvaluate_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_AllEvaluate_Cell.h"

@interface Mine_MyOrder_AllEvaluate_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Norms_Label;

@property (strong, nonatomic) IBOutlet UILabel *Eavluate_Label;

@end

@implementation Mine_MyOrder_AllEvaluate_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_MyOrder_Evalute_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    self.Time_Label.text = model.createtime;
    self.Text_Label.text = model.content;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.left_avatar]];
    self.Title_Label.text = model.left_name;
    self.Norms_Label.text = model.left_remark;
    if ([model.grade intValue] == 1) {
        self.Eavluate_Label.text = @"很差";
    }else if ([model.grade intValue] == 2) {
        self.Eavluate_Label.text = @"差";
    }else if ([model.grade intValue] == 3) {
        self.Eavluate_Label.text = @"一般";
    }else if ([model.grade intValue] == 4) {
        self.Eavluate_Label.text = @"好";
    }else if ([model.grade intValue] == 5) {
        self.Eavluate_Label.text = @"非常好";
    }
    
}

@end
