//
//  Publish_Lable_VC.m
//  QFC
//
//  Created by tiaoxin on 2019/4/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Publish_Lable_VC.h"

@interface Publish_Lable_VC ()

@property (strong, nonatomic) IBOutlet UITextField *Text_Label;

@property (strong, nonatomic) IBOutlet UIButton *Add_Button;

@property (nonatomic, strong) NSMutableArray *hotlist_Array;

@property (nonatomic, strong) NSMutableArray *list_Array;

@property (nonatomic, strong) UIView *BackView;

@property (nonatomic, assign) NSInteger Number;

@end

@implementation Publish_Lable_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Number = 0;
    [self.view addSubview:self.BackView];
    [self LoadingDataSoure];
}
- (IBAction)LiftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddBiuttonClick:(id)sender {
    if (self.Text_Label.text.length) {
        [self AddLabelToBacker];
    }else {
        [MBProgressHUD py_showError:@"请输入文字" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }
}

- (IBAction)SureButtonClick:(id)sender {
    NSString *LabelString = @"";
    for (Publish_Model *model in self.hotlist_Array) {
        if (model.State) {
            LabelString = LabelString.length ? [NSString stringWithFormat:@"%@,%@", LabelString, model.name] : [NSString stringWithFormat:@"%@", model.name];
        }
    }
    for (Publish_Model *model in self.list_Array) {
        if (model.State) {
            LabelString = LabelString.length ? [NSString stringWithFormat:@"%@,%@", LabelString, model.name] : [NSString stringWithFormat:@"%@", model.name];
        }
    }
//    NSLog(@"%@", LabelString);
    if (self.publickBlock) {
        self.publickBlock(LabelString);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSMutableArray *)hotlist_Array {
    if (!_hotlist_Array) {
        _hotlist_Array = [[NSMutableArray alloc] init];
    }
    return _hotlist_Array;
}

- (NSMutableArray *)list_Array {
    if (!_list_Array) {
        _list_Array = [[NSMutableArray alloc] init];
    }
    return _list_Array;
}

- (UIView *)BackView {
    if (!_BackView) {
        _BackView = [[UIView alloc] init];
        _BackView.backgroundColor = QFC_BackColor_Gray;
    }
    return _BackView;
}

- (void)setUPUI {
    [self.BackView removeAllSubviews];
    UILabel *Title_Label_1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        label.textColor = QFC_Color_30AC65;
        label.text = @"我的标签";
        label;
    });
    [self.BackView addSubview:Title_Label_1];
    [Title_Label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15.0f);
        make.left.equalTo(self.BackView.mas_left).offset(10.0f);
        make.top.equalTo(self.BackView.mas_top).offset(10.0f);
    }];
    for (int i = 0; i < self.list_Array.count; i++) {
        Publish_Model *model = self.list_Array[i];
        PublishBT * PBT = ({
            PublishBT *button = [[PublishBT alloc] init];
            [button setTitle:[NSString stringWithFormat:@"#%@",model.name] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
            [button addTarget:self action:@selector(MyPublishBTClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            button.tag = 498480 + i;
            [button.Delect_BT addTarget:self action:@selector(PublishDelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.Delect_BT.tag = 948480;
            [button setTitleColor:QFC_Color_333333 forState:UIControlStateNormal];
            button.layer.cornerRadius = 12.0f;//设置圆角弧度
            button.selected = model.State;
            if (model.State) {
                button.backgroundColor = QFC_Color_30AC65;
            }else {
                button.backgroundColor = [UIColor whiteColor];
            }
            button;
        });
        [self.BackView addSubview:PBT];
        [PBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake((SCREEN_WIDTH - 50.0f) / 4.0f, 25.0f));
            make.top.equalTo(Title_Label_1.mas_bottom).offset((i / 4) * 35.0f + 10.0f);
            make.left.equalTo(self.BackView.mas_left).offset((i % 4) * ((SCREEN_WIDTH - 50.0f) / 4.0f) + ((i % 4) * 10.0f) +  10.0f);
        }];
    }
    
    UILabel *Title_Label_2 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        label.textColor = QFC_Color_30AC65;
        label.text = @"猜你喜欢";
        label;
    });
    [self.BackView addSubview:Title_Label_2];
    [Title_Label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15.0f);
        make.left.equalTo(self.BackView.mas_left).offset(10.0f);
        make.top.equalTo(Title_Label_1.mas_bottom).offset(((self.list_Array.count % 4 ? 1 : 0) + self.list_Array.count / 4) * 35.0f + 10);
    }];
    for (int i = 0; i < self.hotlist_Array.count; i++) {
        Publish_Model *model = self.hotlist_Array[i];
        PublishBT * PBT = ({
            PublishBT *button = [[PublishBT alloc] init];
            [button setTitle:[NSString stringWithFormat:@"#%@",model.name] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
            [button addTarget:self action:@selector(LikePublishBT:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:QFC_Color_333333 forState:UIControlStateNormal];
            button.Delect_BT.hidden = YES;
            button.layer.cornerRadius = 12.0f;//设置圆角弧度
            button.tag = 565740 + i;
            button.selected = model.State;
            if (model.State) {
                button.backgroundColor = QFC_Color_30AC65;
            }else {
                button.backgroundColor = [UIColor whiteColor];
            }
            button;
        });
        [self.BackView addSubview:PBT];
        [PBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake((SCREEN_WIDTH - 50.0f) / 4.0f, 25.0f)).priorityHigh();
            make.top.equalTo(Title_Label_2.mas_bottom).offset((i / 4) * 35.0f + 10.0f).priorityHigh();
            make.left.equalTo(self.BackView.mas_left).offset((i % 4) * ((SCREEN_WIDTH - 50.0f) / 4.0f) + ((i % 4) * 10.0f) +  10.0f).priorityHigh();
        }];
        if (i < self.hotlist_Array.count - 1) {
            [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view).priorityHigh();
                make.top.equalTo(self.Text_Label.mas_bottom).offset(10.0f).priorityHigh();
                make.bottom.equalTo(Title_Label_2.mas_bottom).offset(((self.hotlist_Array.count % 4 ? 1 : 0) + self.hotlist_Array.count / 4) * 35.0f + 10.0f).priorityHigh();
            }];
        }
    }
}

#pragma mark----UPdata

 /**
 社区广场 添加标签页面 获取热门标签 获取自己添加的标签
 URL : https://www.txkuaiyou.com/index/Plazas/hotLabels
 参数 :
 uid
 用户ID
 */
- (void)LoadingDataSoure {
    [self.list_Array removeAllObjects];
    [self.hotlist_Array removeAllObjects];
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_hotLabels parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Hot_Array = [responseObject objectForKey:@"hotlist"];
            for (NSString *Str in Hot_Array) {
                Publish_Model *model = [[Publish_Model alloc] init];
                model.State = NO;
                model.name = Str;
                [self.hotlist_Array addObject:model];
            }
            NSArray *List_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in List_Array) {
                Publish_Model *model = [Publish_Model mj_objectWithKeyValues:dic];
                model.State = NO;
                [self.list_Array addObject:model];
            }
            [self setUPUI];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)AddLabelToBacker {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.Text_Label.text forKey:@"name"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_myLabelAdd parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"添加成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}
/**
 社区广场 删除标签
 URL : https://www.txkuaiyou.com/index/Plazas/labelDel
 参数 :
 uid
 用户ID
 labelid
 标签ID
 */
- (void)DelectButtonToBacker:(NSString *)LabelID {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:LabelID forKey:@"labelid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_labelDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

//我的标签点击状态
- (void)MyPublishBTClick:(PublishBT *)button {
    /*for (int i = 0; i < self.list_Array.count; i++) {
        if (button.tag == 498480 + i) {
            button.selected = YES;
            button.backgroundColor = QFC_Color_30AC65;
        }else {
            PublishBT *BT = [self.BackView viewWithTag:498480 + i];
            BT.selected = NO;
            BT.backgroundColor = [UIColor whiteColor];
        }
    }*/
    if (self.Number >= 5 && !button.selected) {
        [MBProgressHUD py_showError:@"最多选择5个标签" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }
    Publish_Model *model = self.list_Array[(button.tag - 498480) == 0 ? 0 : button.tag - 498480];
    button.selected = !button.selected;
    if (button.selected) {
        button.selected = YES;
        model.State = YES;
        button.backgroundColor = QFC_Color_30AC65;
        self.Number += 1;
    }else {
        button.selected = NO;
        model.State = NO;
        button.backgroundColor = [UIColor whiteColor];
        self.Number -= 1;
    }
    self.list_Array[(button.tag - 498480) == 0 ? 0 : button.tag - 498480] = model;
}

//我的标签删除点击
- (void)PublishDelectButtonClick:(UIButton *)Button {
    Publish_Model *model = self.list_Array[Button.tag - 948480];
    [self DelectButtonToBacker:model.Publish_id];
}
//猜你喜欢按钮选择 565740
- (void)LikePublishBT:(PublishBT *)button {
    if (self.Number >= 5 && !button.selected) {
        [MBProgressHUD py_showError:@"最多选择5个标签" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
        return;
    }
    Publish_Model *model = self.hotlist_Array[(button.tag - 565740) == 0 ? 0 : button.tag - 565740];
    button.selected = !button.selected;
    if (button.selected) {
        button.selected = YES;
        model.State = YES;
        button.backgroundColor = QFC_Color_30AC65;
        self.Number += 1;
    }else {
        button.selected = NO;
        model.State = NO;
        button.backgroundColor = [UIColor whiteColor];
        self.Number -= 1;
    }
    self.hotlist_Array[(button.tag - 565740) == 0 ? 0 : button.tag - 565740] = model;
//    565740
}

@end

