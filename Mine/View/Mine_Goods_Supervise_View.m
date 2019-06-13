//
//  Mine_Goods_Supervise_View.m
//  QFC
//
//  Created by tiaoxin on 2019/4/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_Goods_Supervise_View.h"
#define CellID_MineGoodsSuperviseCell  @"MineGoodsSuperviseCell"

@interface Mine_Goods_Supervise_View ()<UITableViewDataSource, UITableViewDelegate, MineGoodsSuperviseCellDelegate>

@property (nonatomic, strong) Basic_TableView *tableView;

@property (nonatomic, strong) CustomBT *All_BT;
@property (nonatomic, strong) CustomBT *Delect_BT;
@property (nonatomic, strong) UIButton *UP_BT;
@property (nonatomic, strong) UIButton *Down_BT;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Mine_Goods_Supervise_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPUI];
    }
    return self;
}
- (void)setUPUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Goods_Supervise_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineGoodsSuperviseCell];
    /*UIView *DownView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:DownView];
    [DownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self);
        make.height.offset(50.0f);
    }];
    [DownView addSubview:self.All_BT];
    [self.All_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(DownView);
        make.width.offset(80.0f);
    }];
    UIView *Line_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    [DownView addSubview:Line_View];
    [Line_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1.0f);
        make.top.bottom.equalTo(DownView);
        make.left.equalTo(self.All_BT.mas_right);
    }];
    [DownView addSubview:self.Delect_BT];
    [self.Delect_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.All_BT);
        make.left.equalTo(Line_View.mas_right);
        make.width.mas_offset((SCREEN_WIDTH - 160.0f)/2.0f);
    }];
    
    [DownView addSubview:self.UP_BT];
    [self.UP_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(DownView);
        make.left.equalTo(self.Delect_BT.mas_right);
    }];
    [DownView addSubview:self.Down_BT];
    [self.Down_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.UP_BT.mas_right);
        make.right.equalTo(DownView.mas_right);
        make.top.bottom.equalTo(DownView);
    }];*/
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self addSubview:self.tableView];
    
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.tableView.Page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf LoadingDataSoure];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.tableView.Page += 1;
        [weakSelf LoadingDataSoure];
    }];
}

- (void)TabelViewBeginDataSoure {
    [self.tableView beginFresh];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)UpDataUPButtonFram:(NSInteger)buttonTip {
    [self.UP_BT mas_updateConstraints:^(MASConstraintMaker *make) {
        if (buttonTip == 1) {
            make.width.mas_offset(0);
        }else if (self.index == 2){
            make.width.mas_offset(SCREEN_WIDTH - 160.0f);
        }else {
            make.width.mas_offset((SCREEN_WIDTH - 160.0f)/2.0f);
        }
    }];
}

- (Basic_TableView *)tableView {
    if (!_tableView) {
        _tableView = [[Basic_TableView alloc] init];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = QFC_BackColor_Gray;
    }
    return _tableView;
}

- (CustomBT *)All_BT {
    if (!_All_BT) {
        _All_BT = [[CustomBT alloc] init];
        [_All_BT setTitle:@"全选" forState:UIControlStateNormal];
        [_All_BT setImage:[UIImage imageNamed:@"icon_Mine_SetUP_duigou_kong"] forState:UIControlStateNormal];
        [_All_BT setImage:[UIImage imageNamed:@"icon_Mine_SetUP_duigou"] forState:UIControlStateSelected];
        _All_BT.BTStyle = ImageLeftTitleRight;
//        _All_BT.ImageTopTitleBottom_MultipliedBy = 0.1f;
        _All_BT.ImageORTitle_Interval = 5.0f;
        _All_BT.titleLabel.textAlignment = NSTextAlignmentLeft;
        _All_BT.Interval = 15.0f;
        [_All_BT setTitleColor:QFC_Color_333333 forState:UIControlStateNormal];
        _All_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        _All_BT.backgroundColor = [UIColor whiteColor];
//        [_All_BT addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _All_BT.tag = 498758;
    }
    return _All_BT;
}
- (CustomBT *)Delect_BT {
    if (!_Delect_BT) {
        _Delect_BT = [[CustomBT alloc] init];
        [_Delect_BT setTitle:@"删除" forState:UIControlStateNormal];
        [_Delect_BT setImage:[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        _Delect_BT.BTStyle = ImageLeftTitleRight;
//        _Delect_BT.ImageTopTitleBottom_MultipliedBy = 0.1f;
        _Delect_BT.ImageORTitle_Interval = 5.0f;
        _Delect_BT.titleLabel.textAlignment = NSTextAlignmentLeft;
        _Delect_BT.Interval = 15.0f;
        [_Delect_BT setTitleColor:QFC_Color_333333 forState:UIControlStateNormal];
        _Delect_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        _Delect_BT.backgroundColor = [UIColor whiteColor];
        //        [_All_BT addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //        _All_BT.tag = 498758;
    }
    return _Delect_BT;
}

- (UIButton *)UP_BT {
    if (!_UP_BT) {
        _UP_BT = [[UIButton alloc] init];
        [_UP_BT setTitle:@"上架商品" forState:UIControlStateNormal];
        _UP_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        [_UP_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _UP_BT.backgroundColor = QFC_Color_55CC88;
    }
    return _UP_BT;
}
- (UIButton *)Down_BT {
    if (!_Down_BT) {
        _Down_BT = [[UIButton alloc] init];
        [_Down_BT setTitle:@"下架商品" forState:UIControlStateNormal];
        _Down_BT.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightMedium];
        [_Down_BT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Down_BT.backgroundColor = QFC_Color_30AC65;
    }
    return _Down_BT;
}


#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Mine_Goods_Supervise_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineGoodsSuperviseCell];
    cell.delegate = self;
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *back_View = ({
        UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] init];
        view.backgroundColor = QFC_Color_F5F5F5;
        view;
    });
    UILabel *DataTimeLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        label.textColor = QFC_Color_Six;
        label.text = @"12月6日";
        label;
    });
    [back_View addSubview:DataTimeLabel];
    [DataTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back_View.mas_left).offset(20.0f);
        make.top.bottom.equalTo(back_View);
    }];
    
    //    Mine_MyOrder_TableView_HeaderView *headerView = [[Mine_MyOrder_TableView_HeaderView alloc] init];
    //    if (section == 2 || section == 3) {
    //        headerView.Title_Label.text = @"订单号：12345678910";
    //        headerView.Right_imageView.hidden = YES;
    //        headerView.Right_Label.hidden = YES;
    //        return headerView;
    //    }else {
    //        headerView.Icon_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_hui"];
    //        headerView.Title_Label.text = @"臻品果园";
    //        headerView.Right_imageView.image = [UIImage imageNamed:@"icon_WD_Order_Dianpu_ziqu"];
    //        headerView.Right_Label.text = @"自取";
    //        return headerView;
    //    }
    return back_View;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}*/

/**
 商品管理
 店铺发布的商品列表
 URL : https://www.txkuaiyou.com/index/goodss/mygoodslist
 参数 :
 page
 分页默认1
 uid
 用户ID
 */
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[Singleton sharedSingleton].Mid forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [parm setObject:@(self.index) forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_goodss_mygoodslist parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_Goods_Supervise_Model *model = [Mine_Goods_Supervise_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self.tableView hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.tableView.Page == 1) {
            [self.tableView hidenFooterView:YES];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----MineGoodsSuperviseCellDelegate

- (void)MineGoodsSuperviseCellButtonClick:(Mine_Goods_Supervise_Model *)model index:(NSInteger)index {
    if (index == 1) {//上架
        [self POSTgoodssmyGoodsDown:model.Goods_id type:[model.status intValue] ? @"0" : @"1"];
    }else {//删除
        [self POSTgoodssmygoodsDel:model.Goods_id];
    }
}

/**
 1.    店铺发布的商品 上下架
 URL : https://www.txkuaiyou.com/index/goodss/myGoodsDown
 参数 :
 goodsid    字符串 1,2,3
 type    1上架0下架
 */
- (void)POSTgoodssmyGoodsDown:(NSString *)Goodid type:(NSString *)type {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:Goodid forKey:@"goodsid"];
    [parm setObject:type forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_goodss_myGoodsDown parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.tableView beginFresh];
        }
//        [MBProgressHUD py_showError:@"操作失败" toView:nil];
//        [MBProgressHUD setAnimationDelay:0.7f];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

/**
 店铺发布的商品 删除
 URL : https://www.txkuaiyou.com/index/goodss/mygoodsDel
 参数 :
 goodsid
 字符串 1,2,3
 */
- (void)POSTgoodssmygoodsDel:(NSString *)Goodid {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:Goodid forKey:@"goodsid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_goodss_mygoodsDel parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"删除成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self.tableView beginFresh];
        }
//        [MBProgressHUD py_showError:@"操作失败" toView:nil];
//        [MBProgressHUD setAnimationDelay:0.7f];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
