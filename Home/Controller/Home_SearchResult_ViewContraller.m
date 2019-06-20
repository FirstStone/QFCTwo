//
//  Home_SearchResult_ViewContraller.m
//  QFC
//
//  Created by tiaoxin on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_SearchResult_ViewContraller.h"

#define QFC_goodslist @"goodslist"
#define QFC_merchantlist @"merchantlist"
#define QFC_topiclist @"topiclist"
#define QFC_secondlist @"secondlist"

#define CellID_HomeSeachGoodsCell @"HomeSeachGoodsCell"
#define CellID_HomeSeachESCell @"HomeSeachESCell"
#define CellID_HomeSeachHTCell @"HomeSeachHTCell"
#define CellID_HomeSeachShopStoreCell @"HomeSeachShopStoreCell"
@interface Home_SearchResult_ViewContraller ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *DataSoureDictionary;
@end

@implementation Home_SearchResult_ViewContraller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_Seach_Goods_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeSeachGoodsCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_Seach_ES_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeSeachESCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_Seach_HT_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeSeachHTCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_Seach_ShopStore_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeSeachShopStoreCell];
    [self LoadingDataSoure];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (NSMutableDictionary *)DataSoureDictionary {
    if (!_DataSoureDictionary) {
        _DataSoureDictionary = [[NSMutableDictionary alloc] init];
    }
    return _DataSoureDictionary;
}

#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.DataSoureDictionary.count;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *keyArray = [self.DataSoureDictionary allKeys];
    return [[self.DataSoureDictionary objectForKey:keyArray[section]] count];
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *keyArray = [self.DataSoureDictionary allKeys];
    NSArray *DataArray = [self.DataSoureDictionary objectForKey:keyArray[indexPath.section]];
    if ([keyArray[indexPath.section] isEqualToString:QFC_goodslist]) {//商品
        Home_Seach_Goods_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeSeachGoodsCell];
        [cell SetDataSoureToCell:DataArray[indexPath.row]];
        return cell;
        
    }else if ([keyArray[indexPath.section] isEqualToString:QFC_merchantlist]) {//店铺
        Home_Seach_ShopStore_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeSeachShopStoreCell];
        [cell SetDataSoureToCell:DataArray[indexPath.row]];
        return cell;
        
    }else if ([keyArray[indexPath.section] isEqualToString:QFC_topiclist]) {//话题
        Home_Seach_HT_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeSeachHTCell];
        [cell SetDataSoureToCell:DataArray[indexPath.row]];
        return cell;
        
    }else{//二手
        Home_Seach_ES_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeSeachESCell];
        [cell SetDataSoureToCell:DataArray[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        NSArray *keyArray = [self.DataSoureDictionary allKeys];
        NSArray *DataArray = [self.DataSoureDictionary objectForKey:keyArray[indexPath.section]];
        Home_Seach_Model *model = DataArray[indexPath.row];
        if ([keyArray[indexPath.section] isEqualToString:QFC_goodslist]) {//商品
            Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
            VC.goodid = model.SearchID;
            [VC setHidesBottomBarWhenPushed:YES];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([keyArray[indexPath.section] isEqualToString:QFC_merchantlist]) {//店铺
            Home_ShopStore_ViewController *ShopStoreVC = [[Home_ShopStore_ViewController alloc] init];
            ShopStoreVC.Shopid = model.SearchID;
            [ShopStoreVC setHidesBottomBarWhenPushed:YES];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:ShopStoreVC animated:YES];
            
        }else if ([keyArray[indexPath.section] isEqualToString:QFC_topiclist]) {//话题
            Square_HT_Details_VC *detailsVC = [[Square_HT_Details_VC alloc] init];
            detailsVC.item_id = model.SearchID;
            [detailsVC setHidesBottomBarWhenPushed:YES];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
            
        }else{//二手
            Square_HT_Details_VC *detailsVC = [[Square_HT_Details_VC alloc] init];
            detailsVC.item_id = model.SearchID;
            [detailsVC setHidesBottomBarWhenPushed:YES];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}


#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     首页全局搜索
     URL : https://www.txkuaiyou.com/index/Search/SearchHome
     参数 :
     keyword
     搜索内容
     uid
     当前用户ID  没有传0或不传
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:self.SearcgText forKey:@"keyword"];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Search_SearchHome parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *goodslist_Array = [responseObject objectForKey:@"goodslist"];
            if (goodslist_Array.count) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dicDataSoure in goodslist_Array) {
                    Home_Seach_Model *model = [Home_Seach_Model mj_objectWithKeyValues:dicDataSoure];
                    [array addObject:model];
                }
                [self.DataSoureDictionary setObject:array forKey:@"goodslist"];
            }
            NSArray *merchantlist_Array = [responseObject objectForKey:@"merchantlist"];
            if (merchantlist_Array.count) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dicDataSoure in merchantlist_Array) {
                    Home_Seach_Model *model = [Home_Seach_Model mj_objectWithKeyValues:dicDataSoure];
                    [array addObject:model];
                }
                 [self.DataSoureDictionary setObject:array forKey:@"merchantlist"];
            }
            NSArray *topiclist_Array = [responseObject objectForKey:@"topiclist"];
            if (topiclist_Array.count) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dicDataSoure in topiclist_Array) {
                    Home_Seach_Model *model = [Home_Seach_Model mj_objectWithKeyValues:dicDataSoure];
                    [array addObject:model];
                }
                [self.DataSoureDictionary setObject:array forKey:@"topiclist"];
            }
            NSArray *secondlist_Array = [responseObject objectForKey:@"secondlist"];
            if (secondlist_Array.count) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dicDataSoure in secondlist_Array) {
                    Home_Seach_Model *model = [Home_Seach_Model mj_objectWithKeyValues:dicDataSoure];
                    [array addObject:model];
                }
                       [self.DataSoureDictionary setObject:array forKey:@"secondlist"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
