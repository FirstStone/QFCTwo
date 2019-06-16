//
//  Home_ShopStore_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ShopStore_Cell.h"

@interface Home_ShopStore_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UILabel *Score_Label;

@property (strong, nonatomic) IBOutlet UILabel *ShopState_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Distance_Label;

@end

@implementation Home_ShopStore_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetDataSoureToCell:(Home_ShopStore_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.merchant;
    self.Score_Label.text = model.grade;
    self.ShopState_Label.text = [model.business intValue] ? @"正在营业" : @"店铺已打烊";
    self.Time_Label.text = [NSString stringWithFormat:@"营业时间：%@ - %@", model.beginbusiness, model.endbusiness];
}

@end
