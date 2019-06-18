//
//  Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllEvaluate_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/26.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllEvaluate_TableView.h"

#define CellID_MineMyorderShopingAllEvaluateCell @"MineMyorderShopingAllEvaluateCell"
#define CellID_MineMyorderRunErrandsAllEvaluateCell @"MineMyorderRunErrandsAllEvaluateCell"
#define CellID_MineMyOrderHouseKeepingAllEvaluateCell @"MineMyOrderHouseKeepingAllEvaluateCell"

#define CellID_MineMyOrderAllEvaluateCell @"MineMyOrderAllEvaluateCell"
@interface Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllEvaluate_TableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
@implementation Mine_MyOrder_RunErrands_Shoping_HouseKeeping_AllEvaluate_TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = QFC_Color_F5F5F5;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Myorder_RunErrands_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_Myorder_Shoping_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_HouseKeeping_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Mine_MyOrder_AllEvaluate_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MineMyOrderAllEvaluateCell];
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.dataArray removeAllObjects];
            if (weakSelf.index) {
                [weakSelf PostmyevaluateList];
            } else {
                [weakSelf LoadingDataSoure];
            }
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.Page += 1;
            if (weakSelf.index) {
                [weakSelf PostmyevaluateList];
            } else {
                [weakSelf LoadingDataSoure];
            }
        }];
    }
    return self;
}

- (void)TabelViewBeginDataSoure {
    [self beginFresh];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
    Mine_MyOrder_Evalute_Model *model = self.dataArray[indexPath.row];
    Mine_MyOrder_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderAllEvaluateCell];
    [cell setModelToCell:model];
    return cell;
    /*if (indexPath.row == 0) {//跑腿
        Mine_Myorder_RunErrands_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
        //         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        //        cell.scrollerView.originalUrls = []
        return cell;
    }else if(indexPath.row == 1){//跑腿
        Mine_Myorder_RunErrands_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderRunErrandsAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else if (indexPath.row == 2 || indexPath.row == 3) {//商家
        Mine_Myorder_Shoping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else if (indexPath.row == 4){//商家
        Mine_Myorder_Shoping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyorderShopingAllEvaluateCell];
        cell.scrollerView.hidden = NO;
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
        //         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        //        cell.scrollerView.originalUrls = []
        return cell;
    }else if (indexPath.row == 5) {//家政
        Mine_MyOrder_HouseKeeping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
        cell.scrollerView.hidden = YES;
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0.0f);
        }];
        return cell;
    }else {//家政
        Mine_MyOrder_HouseKeeping_AllEvaluate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MineMyOrderHouseKeepingAllEvaluateCell];
        cell.scrollerView.hidden = NO;
        cell.scrollerView.photosMaxCol = 3;
        cell.scrollerView.imagesMaxCountWhenWillCompose = 3;
        NSArray *imageArray = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        [cell.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(70.0f);
        }];
        [cell.contentView layoutIfNeeded];
        [cell.contentView layoutSubviews];
        cell.scrollerView.photosState = PYPhotosViewStateDidCompose;
        cell.scrollerView.hideDeleteView = YES;
        cell.scrollerView.autoSetPhotoState = YES;
        cell.scrollerView.images = [NSMutableArray arrayWithArray:imageArray];
        //         NSArray *imageArray1 = @[[UIImage imageNamed:@"image_3"], [UIImage imageNamed:@"image_4"],[UIImage imageNamed:@"image_5"]];
        //        cell.scrollerView.originalUrls = []
        return cell;
    }*/
}



- (void)LoadingDataSoure {
    /**
     订单 评价列表 我发出的
     URL : https://www.txkuaiyou.com/index/Orderevaluates/evaluateList
     参数 :
     uid
     用户ID
     page
     分页
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Orderevaluates_evaluateList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_MyOrder_Evalute_Model *model = [Mine_MyOrder_Evalute_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)PostmyevaluateList {
    /*
     订单 评价列表 我接到的
     URL : https://www.txkuaiyou.com/index/Orderevaluates/myevaluateList
     参数 :
     uid
     用户ID
     page
     分页
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Orderevaluates_myevaluateList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Mine_MyOrder_Evalute_Model *model = [Mine_MyOrder_Evalute_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.Page == 1) {
            [self hidenFooterView:YES];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
