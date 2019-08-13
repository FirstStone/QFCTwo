//
//  Square_HT_Text_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_Text_Cell.h"

@interface Square_HT_Text_Cell ()
@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Lable;
@property (strong, nonatomic) IBOutlet UIButton *Type_BT;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;
@property (strong, nonatomic) IBOutlet UILabel *text_Label;
@property (strong, nonatomic) IBOutlet UIButton *ding_BT;
@property (strong, nonatomic) IBOutlet UIButton *pinglin_BT;
@property (strong, nonatomic) IBOutlet UIButton *xihuang_BT;
@property (strong, nonatomic) IBOutlet UIButton *fenxiang_BT;
@property (strong, nonatomic) IBOutlet UIButton *Address_BT;

@property (nonatomic, strong) SquareRecommend_Model *My_Model;
@end

@implementation Square_HT_Text_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick:)];
    [self.Photo_imageView addGestureRecognizer:tapZer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)iconImageViewClick:(UIGestureRecognizer *)zer {
    if ([self.delegate respondsToSelector:@selector(SquareHTTextCellIconImageViewClick:)]) {
        [self.delegate SquareHTTextCellIconImageViewClick:self.My_Model.uid];
    }
}

- (IBAction)MoreButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTTextCellMoreButtonClick:)]) {
        [self.delegate SquareHTTextCellMoreButtonClick:self.My_Model];
    }
    
}

- (void)setDataSoureToCell:(SquareRecommend_Model *)model {
    self.My_Model = model;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Time_Label.text = model.createtime;
    self.text_Label.text = model.content;
    [self.ding_BT setTitle:model.like_sum forState:UIControlStateNormal];
    [self.pinglin_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.xihuang_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.fenxiang_BT setTitle:model.share_sum forState:UIControlStateNormal];
    [self.Type_BT setTitle:model.Type_name forState:UIControlStateNormal];
//    [self.Address_BT setTitle:model.address forState:UIControlStateNormal];
}

@end
