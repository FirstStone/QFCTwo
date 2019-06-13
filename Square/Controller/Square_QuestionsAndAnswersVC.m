//
//  Square_QuestionsAndAnswersVC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/15.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_QuestionsAndAnswersVC.h"

@interface Square_QuestionsAndAnswersVC ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *DownBackView;

@property (nonatomic, strong) NSArray *itemArray;

//@property (strong, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *Back_view;



@property (nonatomic, strong) UILabel *Title_Label;
@property (nonatomic, strong) UILabel *Tip_Label;
@property (nonatomic, strong) UILabel *Answer_Label;

@property (nonatomic, strong) UIImageView *Lift_imageview;
@property (nonatomic, strong) UIImageView *Middle_imageview;
@property (nonatomic, strong) UIImageView *Right_imageview;


@property (nonatomic, strong) UIImageView *photo_View;

@property (nonatomic, strong) UIButton *Folllow_BT;

@property (nonatomic, strong) UILabel *Name_Label;


@end

@implementation Square_QuestionsAndAnswersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *DownViewZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DownViewClick:)];
    [self.DownBackView addGestureRecognizer:DownViewZer];
    self.itemArray = @[@"默认", @"置顶"];
    if ([self.uid intValue]) {
        UIView *Top_View = [self setTopViewIconView];
        //    TopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 95.0f);
        [self.Back_view addSubview:Top_View];
        [Top_View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.Back_view);
            make.height.offset(120.0f);
        }];
    }else {
        UIView *Top_View = [self setTopViewTaxtView];
        //    TopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 95.0f);
        [self.Back_view addSubview:Top_View];
        [Top_View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.Back_view);
            make.height.offset(120.0f);
        }];
    }
    
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"%lf, %d, %lf, %lf", SCREEN_WIDTH * index, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f));
        //SCREEN_WIDTH * index, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f)
        //0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f)
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f)) animated:YES];
    }];//is_IPhone_X ? 88.0f + 120.0f : 64.0f+ 120.0f
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.itemArray.count; i++) {
         NSLog(@"%lf, %d, %lf, %lf", SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f));
        Square_QuestionAndAnswersTV *LiftTableview = [[Square_QuestionAndAnswersTV alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f)) style:UITableViewStylePlain];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        LiftTableview.item_ID = self.item_id;
        [LiftTableview beginFresh];
        [self.scrollView addSubview:LiftTableview];
    }
    [self LoadingDataSoure];
}

- (UIView *)setTopViewIconView {
    UIView *contentView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [contentView addSubview:self.photo_View];
    [self.photo_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30.0f, 30.0f));
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.top.equalTo(contentView.mas_top).offset(10.0f);
    }];
    
    [contentView addSubview:self.Name_Label];
    [self.Name_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(12.0f);
        make.centerY.equalTo(self.photo_View.mas_centerY);
        make.left.equalTo(self.photo_View.mas_right).offset(10.0f);
    }];
    [contentView addSubview:self.Folllow_BT];
    [self.Folllow_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60.0f, 18.0f));
        make.centerY.equalTo(self.Name_Label.mas_centerY);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
    }];
    [contentView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15.0f);
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.top.equalTo(self.photo_View.mas_bottom).offset(10.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
    }];
    
    [contentView addSubview:self.Lift_imageview];
    [self.Lift_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30.0f, 30.0f));
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.top.equalTo(self.Title_Label.mas_bottom).offset(10.0f);
    }];
    
    [contentView addSubview:self.Middle_imageview];
    [self.Middle_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(self.Lift_imageview);
        make.left.equalTo(self.Lift_imageview.mas_left).offset(15.0f);
    }];
    
    [contentView addSubview:self.Right_imageview];
    [self.Right_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(self.Middle_imageview);
        make.left.equalTo(self.Middle_imageview.mas_left).offset(15.0f);
    }];
    
    [contentView addSubview:self.Answer_Label];
    [self.Answer_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(10.0f);
        make.left.equalTo(self.Right_imageview.mas_right).offset(10.0f);
        make.centerY.equalTo(self.Right_imageview.mas_centerY);
    }];
    
    [contentView addSubview:self.segmentedControl];
    
    
    
    return contentView;
}


- (UIView *)setTopViewTaxtView {
    UIView *contentView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    [contentView addSubview:self.Title_Label];
    [self.Title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20.0f);
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.top.equalTo(contentView.mas_top).offset(20.0f);
        make.right.equalTo(contentView.mas_right).offset(-10.0f);
    }];
    
    [contentView addSubview:self.Tip_Label];
    [self.Tip_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.Title_Label);
        make.height.offset(0.0f);
        make.top.equalTo(self.Title_Label.mas_bottom).offset(10.0f);
    }];
    
    [contentView addSubview:self.Lift_imageview];
    [self.Lift_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30.0f, 30.0f));
        make.left.equalTo(contentView.mas_left).offset(10.0f);
        make.top.equalTo(self.Tip_Label.mas_bottom).offset(15.0f);
    }];
    
    [contentView addSubview:self.Middle_imageview];
    [self.Middle_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(self.Lift_imageview);
        make.left.equalTo(self.Lift_imageview.mas_left).offset(15.0f);
    }];
    
    [contentView addSubview:self.Right_imageview];
    [self.Right_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(self.Middle_imageview);
        make.left.equalTo(self.Middle_imageview.mas_left).offset(15.0f);
    }];
    
    [contentView addSubview:self.Answer_Label];
    [self.Answer_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(10.0f);
        make.left.equalTo(self.Right_imageview.mas_right).offset(10.0f);
        make.centerY.equalTo(self.Right_imageview.mas_centerY);
    }];

    [contentView addSubview:self.segmentedControl];
    
    return contentView;
}


#pragma mark----懒加载

- (UIImageView *)photo_View {
    if (!_photo_View) {
        _photo_View = [[UIImageView alloc] init];
        _photo_View.image = [UIImage imageNamed:@"icon_Photo"];
        _photo_View.layer.cornerRadius = 15.0f;
        _photo_View.layer.masksToBounds = YES;
    }
    return _photo_View;
}

- (UILabel *)Name_Label {
    if (!_Name_Label) {
        _Name_Label = [[UILabel alloc] init];
        _Name_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Name_Label.textColor = QFC_Color_333333;
//        _Name_Label.text = @"赵日天";
    }
    return _Name_Label;
}

- (UIButton *)Folllow_BT {
    if (!_Folllow_BT) {
        _Folllow_BT = [[UIButton alloc] init];
        [_Folllow_BT setTitle:@"  +关注  " forState:UIControlStateNormal];
        [_Folllow_BT setTitle:@"  已关注  " forState:UIControlStateSelected];
        [_Folllow_BT setTitleColor:QFC_Color_30AC65 forState:UIControlStateNormal];
        [_Folllow_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _Folllow_BT.titleLabel.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Folllow_BT.layer.cornerRadius = 9.0f;
        _Folllow_BT.backgroundColor = [UIColor whiteColor];
        _Folllow_BT.layer.borderColor = QFC_Color_30AC65.CGColor;
        _Folllow_BT.layer.borderWidth = 1.0f;
        [_Folllow_BT addTarget:self action:@selector(FollowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Folllow_BT;
}

- (UIImageView *)Middle_imageview {
    if (!_Middle_imageview) {
        _Middle_imageview = [[UIImageView alloc] init];
        _Middle_imageview.image = [UIImage imageNamed:@"icon_Photo"];
        _Middle_imageview.layer.cornerRadius = 15.0f;
        _Middle_imageview.layer.masksToBounds = YES;
    }
    return _Middle_imageview;
}

- (UIImageView *)Right_imageview {
    if (!_Right_imageview) {
        _Right_imageview = [[UIImageView alloc] init];
        _Right_imageview.image = [UIImage imageNamed:@"icon_Photo"];
        _Right_imageview.layer.cornerRadius = 15.0f;
        _Right_imageview.layer.masksToBounds = YES;
    }
    return _Right_imageview;
}

- (UIImageView *)Lift_imageview {
    if (!_Lift_imageview) {
        _Lift_imageview = [[UIImageView alloc] init];
        _Lift_imageview.image = [UIImage imageNamed:@"icon_Photo"];
        _Lift_imageview.layer.cornerRadius = 15.0f;
        _Lift_imageview.layer.masksToBounds = YES;
    }
    return _Lift_imageview;
}

- (UILabel *)Title_Label {
    if (!_Title_Label) {
        _Title_Label = [[UILabel alloc] init];
        _Title_Label.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
        _Title_Label.textColor = QFC_Color_333333;
//        _Title_Label.text = @"你觉得哪个城市最适合居住？";
    }
    return _Title_Label;
}

- (UILabel *)Tip_Label {
    if (!_Tip_Label) {
        _Tip_Label = [[UILabel alloc] init];
        _Tip_Label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        _Tip_Label.textColor = QFC_Color_Six;
//        _Tip_Label.text = @"从生活、教育、文化、科技、发展实际情况考虑";
    }
    return _Tip_Label;
}

- (UILabel *)Answer_Label {
    if (!_Answer_Label) {
        _Answer_Label = [[UILabel alloc] init];
        _Answer_Label.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightMedium];
        _Answer_Label.textColor = QFC_Color_Six;
//        _Answer_Label.text = @"139人贡献回答";
    }
    return _Answer_Label;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {//CGRectMake(0, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f))
        //CGRectGetMidY(self.DownBackView.frame)
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f + 130.0f : 64.0f+ 130.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f))];
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.backgroundColor = QFC_BackColor_Gray;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f));
        _scrollView.delegate = self;//is_IPhone_X ? 88.0f + 130.0f : 64.0f+ 130.0f
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 50.0f - 130.0f) : (SCREEN_HEIGHT - 64.0f - 50.0f - 130.0f)) animated:NO];
    }
    return _scrollView;
}


- (HMSegmentedControl *)segmentedControl {//is_IPhone_X ? 88.0f : 64.0f
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100.0f, 70.0f, 100.0f, 40.0f)];
        _segmentedControl.sectionTitles = self.itemArray;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : QFC_Color_Six ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : QFC_Color_333333, NSFontAttributeName :[UIFont systemFontOfSize:15.0f weight:UIFontWeightBold]};
        _segmentedControl.selectionIndicatorColor = QFC_Color_30AC65;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    }
    return _segmentedControl;
}

- (void)FollowButtonClick:(UIButton *)button {
    [self setAttentionDataSoure];
}


#pragma mark----ZXCategorySliderBarDelegate

- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark----UPdata
/**
 社区广场 获取问答动态详情
 URL : https://www.txkuaiyou.com/index/Plazas/questionsDetails
 参数 :
 id
 问答ID
 uid
 用户ID
 */

- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.item_id forKey:@"id"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_questionsDetails parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
             NSArray *DataArray = [responseObject objectForKey:@"info"];
            
            for (NSDictionary *dic in DataArray) {
                Square_QuestionsAndAnswers_Top_Model *model = [Square_QuestionsAndAnswers_Top_Model mj_objectWithKeyValues:dic];
                if ([model.uid intValue]) {
                    if ([model.attention intValue]) {
                        self.Folllow_BT.selected = [model.attention intValue];
                        self.Folllow_BT.backgroundColor = QFC_Color_30AC65;
                    }else {
                        self.Folllow_BT.selected = [model.attention intValue];
                        self.Folllow_BT.backgroundColor = [UIColor whiteColor];
                    }
                    [self.photo_View sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
                    self.Name_Label.text = model.nickname;
                    self.Title_Label.text = model.content;
                    self.Answer_Label.text = [NSString stringWithFormat:@"%@人贡献回答", model.discuss_sum];
                    if (model.list.count) {
                        for (int i = 0; i < model.list.count; i ++) {
                            if (i == 0) {
                                [self.Lift_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[0]]];
                            }else if (i == 1) {
                                [self.Middle_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[1]]];
                            }else if (i == 2){
                                [self.Right_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[2]]];
                            }
                        }
                    }else {
                        self.Lift_imageview.hidden = YES;
                        self.Middle_imageview.hidden = YES;
                        self.Right_imageview.hidden = YES;
                        [self.Answer_Label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.Title_Label.mas_left);
                        }];
                    }
                }else {//标题和富文本
                    self.Title_Label.text = model.content;
                    self.Tip_Label.hidden = YES;
                    self.Answer_Label.text = [NSString stringWithFormat:@"%@人贡献回答", model.discuss_sum];
                    if (model.list.count) {
                        for (int i = 0; i < model.list.count; i ++) {
                            if (i == 0) {
                                [self.Lift_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[0]]];
                            }else if (i == 1) {
                                [self.Middle_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[1]]];
                            }else if (i == 2){
                                [self.Right_imageview sd_setImageWithURL:[NSURL URLWithString:model.list[2]]];
                            }
                        }
                    }else {
                        self.Lift_imageview.hidden = YES;
                        self.Middle_imageview.hidden = YES;
                        self.Right_imageview.hidden = YES;
                        [self.Answer_Label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.Title_Label.mas_left);
                        }];
                    }
                }
            }
        }else {
            [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


/**关注*/
/**type=1关注  2取消关注*/
- (void)setAttentionDataSoure {
    self.Folllow_BT.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.uid forKey:@"pid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Users_attention parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }
        self.Folllow_BT.userInteractionEnabled = YES;
    } failure:^(NSError * _Nonnull error) {
        self.Folllow_BT.userInteractionEnabled = YES;
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)DownViewClick:(UIGestureRecognizer *)Zer {
    Square_Answer_VC *answerVC = [[Square_Answer_VC alloc] init];
    answerVC.My_Nav = self.navigationController;
    answerVC.Answerid = self.item_id;
    [self.navigationController pushViewController:answerVC animated:YES];
}


@end
