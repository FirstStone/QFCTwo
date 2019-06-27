//
//  Square_WD_ImageAndText_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_WD_ImageAndText_Cell.h"

@interface Square_WD_ImageAndText_Cell ()
@property (strong, nonatomic) IBOutlet UILabel *Title_Lable;

@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Lable;
@property (strong, nonatomic) IBOutlet UILabel *Ding_Label;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;
@property (strong, nonatomic) IBOutlet UILabel *Liulan_Label;

@property (strong, nonatomic) IBOutlet UIImageView *image_View;

@property (nonatomic, strong) SquareRecommend_Model *My_Model;

@property (nonatomic, strong) Square_WD_Model *WD_Model;

@end

@implementation Square_WD_ImageAndText_Cell

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
    if ([self.delegate respondsToSelector:@selector(SquareWDImageAndTextCellIconimage:)]) {
        if ([self.My_Model.uid intValue]) {
            [self.delegate SquareWDImageAndTextCellIconimage:self.My_Model.uid];
        }else {
            [self.delegate SquareWDImageAndTextCellIconimage:self.WD_Model.uid];
        }
    }
}

- (IBAction)MoreButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareWDImageAndTextCellMoreButtonClick:SquareWDModel:Style:)]) {
        if (self.My_Model) {
            [self.delegate SquareWDImageAndTextCellMoreButtonClick:self.My_Model SquareWDModel:self.WD_Model Style:1];
        }else {
            [self.delegate SquareWDImageAndTextCellMoreButtonClick:self.My_Model SquareWDModel:self.WD_Model Style:2];
        }
    }
    
}

- (void)setDataSoureToCell:(SquareRecommend_Model *)model {
    self.My_Model = model;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Title_Lable.text = model.content;
    self.Text_Label.text = @"";
    self.Liulan_Label.text = [NSString stringWithFormat:@"%@回答",model.discuss_sum];
    self.Ding_Label.text = [NSString stringWithFormat:@"%@人顶", model.like_sum];
}
- (void)setSquareWDModelToCell:(Square_WD_Model *)model {
    self.WD_Model = model;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Title_Lable.text = model.content;
    if (!model.answer_content.length) {
        self.Text_Label.text = @"暂无人回答，快来参与吧！";
    }else {
        self.Text_Label.text = [NSString stringWithFormat:@"%@：%@", model.answer_name, model.answer_content];
    }
    self.Liulan_Label.text = [NSString stringWithFormat:@"%@人点赞",model.like_sum];
    self.Ding_Label.text = [NSString stringWithFormat:@"%@人回答", model.discuss_sum];
}

@end
