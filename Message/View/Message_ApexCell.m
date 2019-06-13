//
//  Message_ApexCell.m
//  QFC
//
//  Created by tiaoxin on 2019/4/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_ApexCell.h"

@interface Message_ApexCell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Title_Label;


@property (strong, nonatomic) IBOutlet UILabel *Time_Label;

@property (strong, nonatomic) IBOutlet UILabel *Sub_Label;

@property (strong, nonatomic) IBOutlet UIImageView *Photo_imageView;

@property (strong, nonatomic) IBOutlet UILabel *Text_Label;

@property (strong, nonatomic) IBOutlet UILabel *Comment_Label;

@end

@implementation Message_ApexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)RightButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MessageApexCellRightButtonClick)]) {
        [self.delegate MessageApexCellRightButtonClick];
    }
}
- (void)setDataSoureToCell:(Message_Apex_Model *)model type:(NSInteger)type {
    if (type == 0) {
        [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        if (model.imgurl.length) {
            [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
        }
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.nickname];
        [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:@"关注了你"];
        [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_999999 range:NSMakeRange(0, redStr.length)];
        [noteStr appendAttributedString:redStr];
        [self.Title_Label setAttributedText:noteStr];
        self.Time_Label.text = model.createtime;
        if ([model.status intValue]) {
            self.RightButton.selected = YES;
            self.RightButton.backgroundColor = QFC_Color_30AC65;
        }else {
            self.RightButton.selected = NO;
            self.RightButton.backgroundColor = [UIColor whiteColor];
        }
        if (model.imgurl.length) {
            self.Photo_imageView.hidden = NO;
            [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
            [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(52.0f);
            }];
        }else {
            self.Photo_imageView.hidden = YES;
            [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(0.0f);
            }];
        }
        self.Sub_Label.hidden = YES;
        [self.Sub_Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        self.Text_Label.text = model.content;
        [self.Comment_Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
    }else {
        /**
         "createtime": "2019-05-17 16:25:08",  //时间
         "userid": 9,
         "nickname": "假装很帅12",  //点赞人
         "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",//头像
         "discusscontent": "发士大夫撒地方",   //点赞的评论
         "id": 4,
         "content": "阿凡达开办费不是的客服表示肯定不付款安抚",  //点赞的动态
         "imgurl": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
         "transmit_id": 0
         "status": 1    //1文字2图
         */
        [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        if (model.imgurl.length) {
            [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
        }
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.nickname];
        [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
        // 改变颜色
        NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:@"关注了你"];
        [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_999999 range:NSMakeRange(0, redStr.length)];
        [noteStr appendAttributedString:redStr];
        [self.Title_Label setAttributedText:noteStr];
        self.Time_Label.text = model.createtime;
        if ([model.status intValue]) {
            self.RightButton.selected = YES;
            self.RightButton.backgroundColor = QFC_Color_30AC65;
        }else {
            self.RightButton.selected = NO;
            self.RightButton.backgroundColor = [UIColor whiteColor];
        }
        if (model.imgurl.length) {
            self.Photo_imageView.hidden = NO;
            [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
            [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(52.0f);
            }];
        }else {
            self.Photo_imageView.hidden = YES;
            [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(0.0f);
            }];
        }
        self.Sub_Label.text = [NSString stringWithFormat:@"%@:%@", [[Singleton sharedSingleton] nickname], model.discusscontent];
        self.Text_Label.text = model.content;
        [self.Comment_Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
    }
}

- (void)setCommentDataSoureToCell:(Message_Comment_Model *)model {
    /**
     avatar = "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg";//评论人头像
     content = "测试结果显示时间已经不";//内容
     createtime = "前天";
     "discount_content" = ""; //发布的评论
     "discount_id" = "";
     "discount_nickname" = "";
     discuss = "份额我哦我";//评论
     id = 96;//评论ID
     imgurl = "https://www.txkuaiyou.com/uploads/fileimg/1558500877904-2019-05-22.png";
     nickname = "假装很帅12";/评论人
     parent = 0;//0 正常评论 非0 回复
     "plaza_id" = 96;//动态ID
     status = 2;
     "transmit_id" = 0;
     userid = 9;//评论人的用户ID
     */
    if ([model.parent intValue]) {
        self.Comment_Label.hidden = NO;
        [self.Comment_Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(30.0f).priorityHigh();
        }];
        self.Comment_Label.text = [NSString stringWithFormat:@"%@:%@",[[Singleton sharedSingleton] nickname], model.discount_content];
    }else {
        [self.Comment_Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
    }
    
    [self.icon_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    if (model.imgurl.length) {
        [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.nickname];
    [noteStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_Six range:NSMakeRange(0, noteStr.length)];
    // 改变颜色
    NSMutableAttributedString * redStr = [[NSMutableAttributedString alloc] initWithString:@"评论了你"];
    [redStr addAttribute:NSForegroundColorAttributeName value:QFC_Color_999999 range:NSMakeRange(0, redStr.length)];
    [noteStr appendAttributedString:redStr];
    [self.Title_Label setAttributedText:noteStr];
    self.Time_Label.text = model.createtime;
    if ([model.status intValue]) {
        self.RightButton.selected = YES;
        self.RightButton.backgroundColor = QFC_Color_30AC65;
    }else {
        self.RightButton.selected = NO;
        self.RightButton.backgroundColor = [UIColor whiteColor];
    }
    if (model.imgurl.length) {
        self.Photo_imageView.hidden = NO;
        [self.Photo_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
        [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(52.0f).priorityHigh();
        }];
    }else {
        self.Photo_imageView.hidden = YES;
        [self.Photo_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(0.0f);
        }];
    }
    self.Sub_Label.text = [NSString stringWithFormat:@"%@", model.discuss];
    self.Text_Label.text = model.content;
}


@end
