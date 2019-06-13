//
//  Square_TextCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_TextCell.h"

@interface Square_TextCell ()
@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Lable;
@property (strong, nonatomic) IBOutlet UIButton *Praise_BT;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;
@property (strong, nonatomic) IBOutlet UILabel *text_Label;
@property (strong, nonatomic) IBOutlet UIButton *ding_BT;
@property (strong, nonatomic) IBOutlet UIButton *pinglin_BT;
@property (strong, nonatomic) IBOutlet UIButton *xihuang_BT;
@property (strong, nonatomic) IBOutlet UIButton *fenxiang_BT;

@property (nonatomic, strong) SquareRecommend_Model *My_Model;

@property (nonatomic, strong) Square_QuestionsAndAnswers_List_Model *My_ListModel;

@end


@implementation Square_TextCell

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
    if ([self.delegate respondsToSelector:@selector(SquareTextCellIconViewClick:)]) {
        if ([self.My_ListModel.item_id intValue]) {
            [self.delegate SquareTextCellIconViewClick:self.My_ListModel.uid];
        }else {
            [self.delegate SquareTextCellIconViewClick:self.My_Model.uid];
        }
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
}

- (void)setSquareQuestionsAndAnswersListModelToCell:(Square_QuestionsAndAnswers_List_Model *)model {
    self.My_ListModel = model;
    self.Praise_BT.hidden = YES;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Time_Label.text = model.createtime;
    self.text_Label.text = model.content;
    [self.ding_BT setTitle:model.like_sum forState:UIControlStateNormal];
    [self.pinglin_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.xihuang_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.fenxiang_BT setTitle:model.share_sum forState:UIControlStateNormal];
}

@end
