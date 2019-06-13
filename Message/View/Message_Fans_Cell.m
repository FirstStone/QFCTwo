//
//  Message_Fans_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_Fans_Cell.h"

@interface Message_Fans_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;

@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UIButton *State_BT;

@property (nonatomic, strong) Message_FansList_Model *MyModel;

@end

@implementation Message_Fans_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)StateButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MessageFansCellButtonClick:)]) {
        [self.delegate MessageFansCellButtonClick:self.MyModel];
    }
}

- (void)setDataSoureToCell:(Message_FansList_Model *)model {
    self.MyModel = model;
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Time_Label.text = model.createtime;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.nickname];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_333333 range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:@"关注了你"];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_999999 range:NSMakeRange(0, redStr.length)];
    [noteStr appendAttributedString:redStr];
    [self.Title_Label setAttributedText:noteStr];
    if ([model.status intValue]) {
        self.State_BT.selected = YES;
        self.State_BT.backgroundColor = QFC_Color_30AC65;
    }else {
        self.State_BT.selected = NO;
        self.State_BT.backgroundColor = [UIColor whiteColor];
    }
}

@end
