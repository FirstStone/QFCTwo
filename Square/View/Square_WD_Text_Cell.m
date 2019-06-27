//
//  Square_WD_Text_Cell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/10.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_WD_Text_Cell.h"
@interface Square_WD_Text_Cell ()
@property (strong, nonatomic) IBOutlet UILabel *Title_Lable;
@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Lable;
@property (strong, nonatomic) IBOutlet UILabel *Ding_Label;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UILabel *Liulan_Label;

@property (nonatomic, strong) SquareRecommend_Model *RecommendModel;
@property (nonatomic, strong) Square_WD_Model *WDModel;

@end

@implementation Square_WD_Text_Cell

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
    if ([self.delegate respondsToSelector:@selector(SquareWDTextCellIconView:)]) {
        if ([self.RecommendModel.uid intValue]) {
            [self.delegate SquareWDTextCellIconView:self.RecommendModel.uid];
        }else {
            [self.delegate SquareWDTextCellIconView:self.WDModel.uid];
        }
    }
}

- (IBAction)MoreButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareWDTextCellMoreButtonClick:QuestionsAndAnswersModel:Style:)]) {
        if (self.RecommendModel) {
            [self.delegate SquareWDTextCellMoreButtonClick:self.RecommendModel QuestionsAndAnswersModel:self.WDModel Style:1];
        }else {
            [self.delegate SquareWDTextCellMoreButtonClick:self.RecommendModel QuestionsAndAnswersModel:self.WDModel Style:2];
        }
    }
    
}

- (void)setDataSoureToCell:(SquareRecommend_Model *)model {
    self.RecommendModel = model;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Title_Lable.text = model.content;
    self.Text_Label.text = @"";
    self.Liulan_Label.text = [NSString stringWithFormat:@"%@回答",model.discuss_sum];
    self.Ding_Label.text = [NSString stringWithFormat:@"%@人顶", model.like_sum];
}

/**
 "id": 9,
 "uid": 1,
 "type_id": 4,
 "nickname": "Xutao",
 "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "content": "爱上大部分看到客服那是快递费卡士大夫阿斯蒂芬",
 "address": "地址",
 "createtime": "昨天",
 "like_sum": "",
 "share_sum": 0,
 "discuss_sum": "",
 "answer_name": "",
 "answer_content": "",
 "answer_img": "",
 "answer_id": "",
 "type": 3,
 "likestatus": 0
 */

- (void)setSquareWDModelToCell:(Square_WD_Model *)model {
    self.WDModel = model;
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    if (!model.answer_content.length) {
        self.Text_Label.text = @"暂无人回答，快来参与吧！";
    }else {
        self.Text_Label.text = [NSString stringWithFormat:@"%@：%@", model.answer_name, model.answer_content];
    }
    self.Title_Lable.text = model.content;
//    self.Text_Label.text = @"";
    self.Liulan_Label.text = [NSString stringWithFormat:@"%@回答",model.discuss_sum];
    self.Ding_Label.text = [NSString stringWithFormat:@"%@人顶", model.like_sum];
}


@end
