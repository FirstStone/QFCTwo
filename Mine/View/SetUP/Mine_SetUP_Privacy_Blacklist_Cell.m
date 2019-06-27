//
//  Mine_SetUP_Privacy_Blacklist_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_SetUP_Privacy_Blacklist_Cell.h"

@interface Mine_SetUP_Privacy_Blacklist_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_View;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UIButton *Sure_BT;

@property (nonatomic, strong) Mine_BlackUser_Model *My_Model;

@end

@implementation Mine_SetUP_Privacy_Blacklist_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSoureToVell:(Mine_BlackUser_Model *)model {
    self.My_Model = model;
    [self.icon_View sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Title_Label.text = model.nickname;
    self.Time_Label.text = model.createtime;
}
- (IBAction)SureButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineSetUPPrivacyBlacklistCellButtonClick:)]) {
        [self.delegate MineSetUPPrivacyBlacklistCellButtonClick:self.My_Model];
    }
}



@end
