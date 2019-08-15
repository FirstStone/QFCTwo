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

@property (nonatomic, strong) Mine_Follow_Model *MyModel;

@end

@implementation Mine_FollowView_TableView_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelToCell:(Mine_Follow_Model *)model {
    self.MyModel = model;
    if (!self.Style) {
        self.icon_imageView.layer.cornerRadius = 20.0f;
        self.icon_imageView.layer.masksToBounds = YES;
    }else {
        self.icon_imageView.layer.cornerRadius = 0.0f;
        self.icon_imageView.layer.masksToBounds = NO;
    }
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Label.text = model.nickname;
    [self.State_BT setTitle:@"已关注" forState:UIControlStateNormal];
}

- (IBAction)StateButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MineFollowViewTableViewCellButtonClick:)]) {
        [self.delegate MineFollowViewTableViewCellButtonClick:self.MyModel];
    }
}


@end
