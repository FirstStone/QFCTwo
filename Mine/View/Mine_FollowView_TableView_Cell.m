//
//  Mine_FollowView_TableView_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/17.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_FollowView_TableView_Cell.h"

@interface Mine_FollowView_TableView_Cell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name_Label;

@property (strong, nonatomic) IBOutlet UIButton *State_BT;

@end

@implementation Mine_FollowView_TableView_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_Follow_Model *)model {
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    [self.State_BT setTitle:@"已关注" forState:UIControlStateNormal];
}

@end
