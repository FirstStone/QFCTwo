//
//  Square_HT_ImageCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_HT_ImageCell.h"

@interface Square_HT_ImageCell ()
@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;
@property (strong, nonatomic) IBOutlet UILabel *Name_Lable;
@property (strong, nonatomic) IBOutlet UIButton *Style_BT;
@property (strong, nonatomic) IBOutlet UILabel *Time_Label;
@property (strong, nonatomic) IBOutlet UILabel *text_Label;
@property (strong, nonatomic) IBOutlet UIButton *ding_BT;
@property (strong, nonatomic) IBOutlet UIButton *pinglin_BT;
@property (strong, nonatomic) IBOutlet UIButton *xihuang_BT;
@property (strong, nonatomic) IBOutlet UIButton *fenxiang_BT;
@property (strong, nonatomic) IBOutlet UIImageView *Lift_image;
@property (strong, nonatomic) IBOutlet UIImageView *Middle_image;

@property (strong, nonatomic) IBOutlet UIImageView *Right_image;


@property (nonatomic, strong) SquareRecommend_Model *My_Model;

@property (nonatomic, strong) Square_QuestionsAndAnswers_List_Model *My_ListModel;

@end

@implementation Square_HT_ImageCell

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
    if ([self.delegate respondsToSelector:@selector(iconViewClick:)]) {
        if ([self.My_ListModel.item_id intValue]) {
            [self.delegate iconViewClick:self.My_ListModel.uid];
        }else {
            [self.delegate iconViewClick:self.My_Model.uid];
        }
    }
}


- (IBAction)PraiseButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SquareHTImageCellButtonClick:SquareRecommendModel:)]) {
        [self.delegate SquareHTImageCellButtonClick:1 SquareRecommendModel:self.My_Model];
    }
    if ([self.delegate respondsToSelector:@selector(SquareHTImageCellButtonClick:SquareQuestionsAndAnswersListModel:)]) {
        [self.delegate SquareHTImageCellButtonClick:1 SquareQuestionsAndAnswersListModel:self.My_ListModel];
    }
}


- (void)setDataSoureToCell:(SquareRecommend_Model *)model {
    self.My_Model = model;
    self.ding_BT.selected = [model.likestatus intValue];
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Time_Label.text = model.createtime;
    [self.ding_BT setTitle:model.like_sum forState:UIControlStateNormal];
    [self.pinglin_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.xihuang_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.fenxiang_BT setTitle:model.share_sum forState:UIControlStateNormal];
    [self.Style_BT setTitle:[NSString stringWithFormat:@"  #%@  ",model.Type_name] forState:UIControlStateNormal];
    if (!model.Type_name.length) {
        self.Style_BT.hidden = YES;
    }
    if (model.imgurl) {
        for (int i = 0; i < model.imgurl.count; i++) {
            switch (i) {
                case 0:
                {
                    self.Lift_image.hidden = NO;
                    [self.Lift_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                }
                    break;
                case 1:
                {
                    self.Middle_image.hidden = NO;
                    [self.Middle_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                    
                }
                    break;
                case 2:
                {
                    self.Right_image.hidden = NO;
                    [self.Right_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                }
                    break;
                default:
                    break;
            }
        }
    }
    if (model.label) {
        NSString *Bstr = @"";
        for (NSString *str in model.label) {
            Bstr = [NSString stringWithFormat:@"%@#%@",Bstr, str];
        }
        NSString *Astr = [NSString stringWithFormat:@"%@%@",model.content, Bstr];
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:Astr attributes:@{NSFontAttributeName:[UIFont fontWithCGFont:UIFontWeightMedium size:16]}];// [UIFont fontWithName:@"SourceHanSansCN-Medium" size: 16],NSForegroundColorAttributeName: QFC_Color_333333
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:Astr];
        [text addAttributes:@{NSForegroundColorAttributeName: QFC_Color_32CCF2} range:NSMakeRange(model.content.length, Bstr.length)];
        self.text_Label.attributedText = text;
    }
}

- (void)setSquareQuestionsAndAnswersListModelToCell:(Square_QuestionsAndAnswers_List_Model *)model {
    self.My_ListModel = model;
    self.ding_BT.selected = [model.likestatus intValue];
    [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.Name_Lable.text = model.nickname;
    self.Time_Label.text = model.createtime;
    [self.ding_BT setTitle:model.like_sum forState:UIControlStateNormal];
    [self.pinglin_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.xihuang_BT setTitle:model.discuss_sum forState:UIControlStateNormal];
    [self.fenxiang_BT setTitle:model.share_sum forState:UIControlStateNormal];
    self.Style_BT.hidden = YES;
    self.text_Label.text = model.content;
//    [self.Style_BT setTitle:[NSString stringWithFormat:@"  #%@  ",model.Type_name] forState:UIControlStateNormal];
    if (model.imgurl) {
        for (int i = 0; i < model.imgurl.count; i++) {
            switch (i) {
                case 0:
                {
                    self.Lift_image.hidden = NO;
                    [self.Lift_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                }
                    break;
                case 1:
                {
                    self.Middle_image.hidden = NO;
                    [self.Middle_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                    
                }
                    break;
                case 2:
                {
                    self.Right_image.hidden = NO;
                    [self.Right_image sd_setImageWithURL:[NSURL URLWithString:model.imgurl[i]]];
                }
                    break;
                default:
                    break;
            }
        }
    }
}


@end
