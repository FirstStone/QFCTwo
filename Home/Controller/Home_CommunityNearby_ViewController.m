//
//  Home_CommunityNearby_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/26.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_ViewController.h"
#define CellID_HomeCommunityNearbyFirstEnjoyOneCell @"HomeCommunityNearbyFirstEnjoyOneCell"
#define CellID_HomeCommunityNearbyEspecialRegionFourCell @"HomeCommunityNearbyEspecialRegionFourCell"
#define CellID_HomeCommunityNearbyEspecialRegionThreeCell @"HomeCommunityNearbyEspecialRegionThreeCell"
#define CellID_HomeCommunityNearbyFirstEnjoyThreeCell @"HomeCommunityNearbyFirstEnjoyThreeCell"
#define CellID_HomeCommunityNearbyEspecialRegionOneCell @"HomeCommunityNearbyEspecialRegionOneCell"
#define CellID_HomeCommunityNearbyFreshFruitSinkOneCell @"HomeCommunityNearbyFreshFruitSinkOneCell"
#define CellID_HomeCommunityNearbyFreshFruitSinkThreeCell @"HomeCommunityNearbyFreshFruitSinkThreeCell"

#define QFC_discountlist @"discountlist"
#define QFC_hotlist @"hotlist"
#define QFC_highlist @"highlist"
#define QFC_fruitslist @"fruitslist"

@interface Home_CommunityNearby_ViewController ()<UINavigationControllerDelegate,FMHorizontalMenuViewDelegate,FMHorizontalMenuViewDataSource,SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, HomeCommunityNearbyFirstEnjoyThreeCellDelegate, HomeCommunityNearbyFreshFruitSinkThreeCellDelegate,HomeCommunityNearbyEspecialRegionThreeCellDelegate>
@property (weak, nonatomic) IBOutlet Basic_TableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (strong, nonatomic) IBOutlet SDCycleScrollView *sdcscrollView;
@property (strong, nonatomic) IBOutlet FMHorizontalMenuView *menuView;

@property (nonatomic, strong) NSMutableArray *Icon_Array;
@property (nonatomic, strong) NSMutableArray *Title_Array;

@property (nonatomic, strong) NSMutableArray *Type_Array;

@property (nonatomic, strong) NSMutableDictionary *dataDic;


@end

@implementation Home_CommunityNearby_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_FirstEnjoy_OneCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_EspecialRegionFour_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyEspecialRegionFourCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_EspecialRegion_ThreeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyEspecialRegionThreeCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_FirstEnjoy_ThreeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_EspecialRegion_OneCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyEspecialRegionOneCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_FreshFruitSink_One_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_FreshFruitSink_Three_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.Icon_Array = @[@"icon_zhekou", @"icon_paotui", @"icon_jiazheng", @"icon_ershou", @"icon_zhaofang", @"icon_weixiu", @"icon_ershou", @"icon_zhaofang", @"icon_weixiu", @"icon_ershou"];
//    self.Title_Array = @[@"水果", @"蔬菜", @"生鲜", @"服装", @"家电", @"箱包", @"数码", @"鞋子", @"手机", @"家纺"];
    [self.SearchBar setImage:[UIImage imageNamed:@"icon_sousuo"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [self.SearchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    searchField.textAlignment = NSTextAlignmentCenter;
//    self.sdcscrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 150) imageNamesGroup:@[@"Home_back_image", @"Home_back_image"]];
    self.sdcscrollView.localizationImageNamesGroup = @[@"Home_back_image", @"Home_back_image"];
    self.sdcscrollView.showPageControl = YES;
    self.sdcscrollView.pageControlDotSize = CGSizeMake(13.0f, 3.0f);
    self.sdcscrollView.currentPageDotColor = QFC_Color(233,233,233);
    self.sdcscrollView.pageDotColor = QFC_Color(48,172,101);
    
    
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.menuView.currentPageDotColor = QFC_Color_30AC65;
    self.menuView.pageDotColor = [UIColor whiteColor];
    self.menuView.pageControlStyle = FMHorizontalMenuViewPageControlStyleNone;
    //    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.hidesForSinglePage = YES;
    [self LoadingDataSoure];
    [self getDataSoureList];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return _dataDic;
}
- (NSMutableArray *)Type_Array {
    if (!_Type_Array) {
        _Type_Array = [[NSMutableArray alloc] init];
    }
    return _Type_Array;
}
- (NSMutableArray *)Title_Array {
    if (!_Title_Array) {
        _Title_Array = [[NSMutableArray alloc] init];
    }
    return _Title_Array;
}
- (NSMutableArray *)Icon_Array {
    if (!_Icon_Array) {
        _Icon_Array = [[NSMutableArray alloc] init];
    }
    return _Icon_Array;
}

- (IBAction)HomeShopingCartClick:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_ShoppingCart_ViewController *shoppingVC = [[Home_ShoppingCart_ViewController alloc] init];
        [shoppingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shoppingVC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

#pragma mark === FMHorizontalMenuViewDataSource
/**
 提供数据的数量
 
 @param horizontalMenuView 控件本身
 @return 返回数量
 */
-(NSInteger)numberOfItemsInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return self.Icon_Array.count;
}

#pragma mark === FMHorizontalMenuViewDelegate
/**
 设置每页的行数 默认 2
 
 @param horizontalMenuView 当前控件
 @return 行数
 */
-(NSInteger)numOfRowsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 2;
}

/**
 设置每页的列数 默认 4
 
 @param horizontalMenuView 当前控件
 @return 列数
 */
-(NSInteger)numOfColumnsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 4;
}
/**
 当选项被点击回调
 
 @param horizontalMenuView 当前控件
 @param index 点击下标
 */
-(void)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView didSelectItemAtIndex:(NSInteger)index{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您点击了第%ld个",index + 1] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
//    if (index == 0) {
//        Home_CommunityNearby_ViewController *CommunityNearbyVC = [[Home_CommunityNearby_ViewController alloc] init];
//        [CommunityNearbyVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:CommunityNearbyVC animated:YES];
//    } else if (index == 1) {
//        Home_RunErrands_ViewController *runVC = [[Home_RunErrands_ViewController alloc] init];
//        [runVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:runVC animated:YES];
//    }else if (index == 2) {
//        Home_HouseKeeping_ViewController *houseVC = [[Home_HouseKeeping_ViewController alloc] init];
//        [houseVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:houseVC animated:YES];
//    }
    
    Home_CommunityNearby_Branch_ViewController *CommunityNearbyVC = [[Home_CommunityNearby_Branch_ViewController alloc] init];
    CommunityNearbyVC.Type = index;
//    CommunityNearbyVC.itemArray = self.Title_Array;
//    CommunityNearbyVC.Title_Array = self.Type_Array;
    [CommunityNearbyVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:CommunityNearbyVC animated:YES];
}
/**
 当前菜单的title
 
 @param horizontalMenuView 当前控件
 @param index 下标
 @return 标题
 */
-(NSString *)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView titleForItemAtIndex:(NSInteger)index{
    return self.Title_Array[index];
}
 /**
 每个菜单的图片地址路径
 
 @param horizontalMenuView 当前控件
 @param index 当前下标
 @return 返回图片的URL路径
 */
- (NSURL *)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView iconURLForItemAtIndex:(NSInteger)index {
    return self.Icon_Array[index];
}

-(CGSize)iconSizeForHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return CGSizeMake(45, 45);
}


#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataDic.count;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *Dickey = [NSMutableArray arrayWithArray:[self.dataDic allKeys]];
    switch (section) {
        case 0:
        {
            if ([Dickey containsObject:QFC_discountlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_discountlist];
                if (DataArray.count == 3) {
                    return 1;
                }else if (DataArray.count == 2) {
                    return 2;
                }else {
                    return DataArray.count;
                }
            }else if ([Dickey containsObject:QFC_hotlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_hotlist];
                if (DataArray.count == 3) {
                    return 1;
                }else if (DataArray.count == 2) {
                    return 2;
                }else {
                    return DataArray.count;
                }
                
            }else if ([Dickey containsObject:QFC_highlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_highlist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }
                
            }else {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }

            }
        }
            break;
        case 1:
        {
            if ([Dickey containsObject:QFC_hotlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_hotlist];
                if (DataArray.count == 3) {
                    return 1;
                }else if (DataArray.count == 2) {
                    return 2;
                }else {
                    return DataArray.count;
                }
            }else if ([Dickey containsObject:QFC_highlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_highlist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }
            }else {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }
            }
        }
            break;
        case 2:
        {
            if ([Dickey containsObject:QFC_highlist]) {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_highlist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }
            }else {
                NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (DataArray.count == 3) {
                    return 1;
                }else {
                    return DataArray.count;
                }
            }
        }
            break;
            
        default:
        {
            NSMutableArray *DataArray = [self.dataDic objectForKey:QFC_fruitslist];
            if (DataArray.count == 3) {
                return 1;
            }else {
                return DataArray.count;
            }
        }
            break;
    }
    
    
//    NSMutableArray *dicArray = [self.dataDic objectForKey:Dickey[section]];
//    if (dicArray.count == 3) {
//        return 1;
//    }else {
//        if ([Dickey[section] isEqualToString:QFC_hotlist]) {
//            return 2;
//        }else {
//            return dicArray.count;
//        }
//    }
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*if ([self.DicCellArray containsObject:QFC_discountlist]) {
        NSMutableArray *disArray = [self.dataDic objectForKey:QFC_discountlist];
        if (disArray.count <= 2) {
            Home_CommunityNearby_EspecialRegion_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionOneCell];
            [cell setModelToCell:disArray[indexPath.row]];
            [self.DicCellArray removeObject:QFC_discountlist];
            return cell;
        }else if (disArray.count == 3) {
            Home_CommunityNearby_EspecialRegion_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionThreeCell];
            [cell setDataSoureToCell:disArray];
            [self.DicCellArray removeObject:QFC_discountlist];
            return cell;
        }else {
            Home_CommunityNearby_EspecialRegionFour_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionFourCell];
            [cell setDataSoureToCell:disArray];
            [self.DicCellArray removeObject:QFC_discountlist];
            return cell;
        }
    }else if ([self.DicCellArray containsObject:QFC_hotlist]){//优享专区
        NSMutableArray *disArray = [self.dataDic objectForKey:QFC_hotlist];
        if (disArray.count <= 2) {
            Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
            [cell setDataSoureToCell:disArray[indexPath.row]];
            [self.DicCellArray removeObject:QFC_hotlist];
            return cell;
        }else if (disArray.count == 3) {
            Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
            [cell setDataSoureToCell:disArray];
            [self.DicCellArray removeObject:QFC_hotlist];
            return cell;
        }else {
            if (indexPath.row == 0) {
                Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
                [cell setDataSoureToCell:disArray[indexPath.row]];
                [self.DicCellArray removeObject:QFC_hotlist];
                return cell;
            }else {
                Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
                [cell setDataSoureToCell:disArray];
                [self.DicCellArray removeObject:QFC_hotlist];
                return cell;
            }
        }
    }else if ([self.DicCellArray containsObject:QFC_highlist]) {//尚品臻选
        NSMutableArray *disArray = [self.dataDic objectForKey:QFC_highlist];
        if (disArray.count <= 2) {
            Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
            [cell setDataSoureToCell:disArray[indexPath.row]];
            [self.DicCellArray removeObject:QFC_highlist];
            return cell;
        }else {
            Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
            [cell setLabelHiddle:YES];
            [cell setDataSoureToCell:disArray];
            [self.DicCellArray removeObject:QFC_highlist];
            return cell;
        }
    }else {//鲜果汇
        NSMutableArray *disArray = [self.dataDic objectForKey:QFC_fruitslist];
        if (disArray.count <= 2) {
            Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
            [cell setDataSoureToCell:disArray[indexPath.row]];
            [self.DicCellArray removeObject:QFC_fruitslist];
            return cell;
        }else {
            Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
            [cell setLabelHiddle:NO];
            [cell setDataSoureToCell:disArray];
            [self.DicCellArray removeObject:QFC_fruitslist];
            return cell;
        }
    }*/
    NSArray *Dickey = [NSMutableArray arrayWithArray:[self.dataDic allKeys]];
    switch (indexPath.section) {
        case 0:
        {
            if ([Dickey containsObject:QFC_discountlist]) {//特惠专区
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_discountlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_EspecialRegion_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionOneCell];
                    [cell setModelToCell:disArray[indexPath.row]];
                    return cell;
                }else if (disArray.count == 3) {
                    Home_CommunityNearby_EspecialRegion_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionThreeCell];
                    cell.delegate = self;
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }else {
                    Home_CommunityNearby_EspecialRegionFour_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionFourCell];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }else if ([Dickey containsObject:QFC_hotlist]){//优享专区
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_hotlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else if (disArray.count == 3) {
                    Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
                    cell.delegate = self;
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }else {
                    if (indexPath.row == 0) {
                        Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
                        [cell setDataSoureToCell:disArray[indexPath.row]];
                        return cell;
                    }else {
                        Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
                        cell.delegate = self;
                        [cell setDataSoureToCell:disArray];
                        return cell;
                    }
                }
            }else if ([Dickey containsObject:QFC_highlist]) {//尚品臻选
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_highlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:YES];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }else {//鲜果汇
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:NO];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }
        }
            break;
        case 1:
        {
            if ([Dickey containsObject:QFC_hotlist]){//优享专区
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_hotlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else if (disArray.count == 3) {
                    Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
                    cell.delegate = self;
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }else {
                    if (indexPath.row == 0) {
                        Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
                        [cell setDataSoureToCell:disArray[indexPath.row]];
                        return cell;
                    }else {
                        Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
                        cell.delegate = self;
                        [cell setDataSoureToCell:disArray];
                        return cell;
                    }
                }
            }else if ([Dickey containsObject:QFC_highlist]) {//尚品臻选
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_highlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:YES];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }else {//鲜果汇
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:NO];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }
        }
            break;
        case 2:
        {
             if ([Dickey containsObject:QFC_highlist]) {//尚品臻选
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_highlist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:YES];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }else {//鲜果汇
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:NO];
                    [cell setDataSoureToCell:disArray];
                    return cell;
                }
            }
        }
            break;
        default:
        {
            //鲜果汇
                NSMutableArray *disArray = [self.dataDic objectForKey:QFC_fruitslist];
                if (disArray.count <= 2) {
                    Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
                    [cell setDataSoureToCell:disArray[indexPath.row]];
                    return cell;
                }else {
                    Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
                    cell.delegate = self;
                    [cell setLabelHiddle:NO];
                    [cell setDataSourefruitslistToCell:disArray];
                    return cell;
                }
        }
            break;
    }
    /*if (indexPath.section == 0) {//特惠专区
        if (indexPath.row == 0) {
            Home_CommunityNearby_EspecialRegionFour_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionFourCell];
            return cell;
        }else if (indexPath.row == 1) {
            Home_CommunityNearby_EspecialRegion_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionOneCell];
            return cell;
        }else {
            Home_CommunityNearby_EspecialRegion_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyEspecialRegionThreeCell];
            return cell;
        }
        
    }else if (indexPath.section == 1) {//优享专区
        if (indexPath.row == 0) {
            Home_CommunityNearby_FirstEnjoy_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyOneCell];
            return cell;
        }else {
            Home_CommunityNearby_FirstEnjoy_ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFirstEnjoyThreeCell];
            return cell;
        }
    }else if (indexPath.section == 2) {//尚品精选
        if (indexPath.row == 0) {
            Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
            [cell setLabelHiddle:YES];
            return cell;
        } else {
            Home_CommunityNearby_FreshFruitSink_One_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkOneCell];
            return cell;
        }
    }  else {//鲜果汇
        Home_CommunityNearby_FreshFruitSink_Three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityNearbyFreshFruitSinkThreeCell];
        [cell setLabelHiddle:NO];
        return cell;
    }*/
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Home_CommunityNearby_SectionHeader_View *hederView = [[Home_CommunityNearby_SectionHeader_View alloc] init];
//    [hederView.More_BT setTitle:@"查看更多" forState:UIControlStateNormal];
   /* if ([self.SectionHeaderArray containsObject:QFC_discountlist]) {
        hederView.Title_Label.text = @"#特惠专区";
        hederView.Title_Label.textColor = QFC_Color_F2793A;
        hederView.Sub_Label.text = @"特价折扣区";
        [self.SectionHeaderArray removeObject:QFC_discountlist];
        
    }else if ([self.SectionHeaderArray containsObject:QFC_hotlist]){
        hederView.Title_Label.text = @"#优享专区";
        hederView.Title_Label.textColor = QFC_Color_FFD21C;
        hederView.Sub_Label.text = @"物美价廉热销中";
        [self.SectionHeaderArray removeObject:QFC_hotlist];
        
    }else if ([self.SectionHeaderArray containsObject:QFC_highlist]) {
        hederView.Title_Label.text = @"#尚品臻选";
        hederView.Title_Label.textColor = QFC_Color_3AABF2;
        hederView.Sub_Label.text = @"高档商品一网打尽";
        [self.SectionHeaderArray removeObject:QFC_highlist];
        
    }else if ([self.SectionHeaderArray containsObject:QFC_fruitslist]) {
        hederView.Title_Label.text = @"#鲜果汇";
        hederView.Title_Label.textColor = QFC_Color_55CC88;
        hederView.Sub_Label.text = @"水果专场";
        [self.SectionHeaderArray removeObject:QFC_fruitslist];
    }*/
    NSArray *Dickey = [self.dataDic allKeys];
    switch (section) {
        case 0:
        {
            if ([Dickey containsObject:QFC_discountlist]) {
                hederView.Title_Label.text = @"#特惠专区";
                hederView.Title_Label.textColor = QFC_Color_F2793A;
                hederView.Sub_Label.text = @"特价折扣区";
            }else if ([Dickey containsObject:QFC_hotlist]){
                hederView.Title_Label.text = @"#优享专区";
                hederView.Title_Label.textColor = QFC_Color_FFD21C;
                hederView.Sub_Label.text = @"物美价廉热销中";
            }else if ([Dickey containsObject:QFC_highlist]) {
                hederView.Title_Label.text = @"#尚品臻选";
                hederView.Title_Label.textColor = QFC_Color_3AABF2;
                hederView.Sub_Label.text = @"高档商品一网打尽";
            }else if ([Dickey containsObject:QFC_fruitslist]) {
                hederView.Title_Label.text = @"#鲜果汇";
                hederView.Title_Label.textColor = QFC_Color_55CC88;
                hederView.Sub_Label.text = @"水果专场";
            }
        }
            break;
            case 1:
        {
            if ([Dickey containsObject:QFC_hotlist]){
                hederView.Title_Label.text = @"#优享专区";
                hederView.Title_Label.textColor = QFC_Color_FFD21C;
                hederView.Sub_Label.text = @"物美价廉热销中";
            }else if ([Dickey containsObject:QFC_highlist]) {
                hederView.Title_Label.text = @"#尚品臻选";
                hederView.Title_Label.textColor = QFC_Color_3AABF2;
                hederView.Sub_Label.text = @"高档商品一网打尽";
            }else if ([Dickey containsObject:QFC_fruitslist]) {
                hederView.Title_Label.text = @"#鲜果汇";
                hederView.Title_Label.textColor = QFC_Color_55CC88;
                hederView.Sub_Label.text = @"水果专场";
            }
        }
            break;
        case 2:
        {
            if ([Dickey containsObject:QFC_highlist]) {
                hederView.Title_Label.text = @"#尚品臻选";
                hederView.Title_Label.textColor = QFC_Color_3AABF2;
                hederView.Sub_Label.text = @"高档商品一网打尽";
            }else if ([Dickey containsObject:QFC_fruitslist]) {
                hederView.Title_Label.text = @"#鲜果汇";
                hederView.Title_Label.textColor = QFC_Color_55CC88;
                hederView.Sub_Label.text = @"水果专场";
            }
        }
            break;
        default:
        {
            hederView.Title_Label.text = @"#鲜果汇";
            hederView.Title_Label.textColor = QFC_Color_55CC88;
            hederView.Sub_Label.text = @"水果专场";
        }
            break;
    }
    return hederView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}
/**
 //商品分类列表
 https://www.txkuaiyou.com/index/types/typelist?uid=8&page=1
 */
#pragma mark----UPdata
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_typelist parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                 Home_CommunityNearby_Model *model = [Home_CommunityNearby_Model  mj_objectWithKeyValues:dic];
                [self.Type_Array addObject:model];
                [self.Icon_Array addObject:model.imgurl];
                [self.Title_Array addObject:model.Type_name];
            }
            [self.menuView reloadData];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}
/**
 //周边商城首页
 Route::rule('goodshome/:uid/:page','index/Goodss/goodsHome');
 */
- (void)getDataSoureList {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_goodsHome parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //水果汇  fruitslist
            NSArray *fruitslistArray = [responseObject objectForKey:QFC_fruitslist];
            if (fruitslistArray.count) {
                NSMutableArray *fruitslist_MiddleArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in fruitslistArray) {
                    Home_CommunityNearby_Activity_Model *model = [Home_CommunityNearby_Activity_Model mj_objectWithKeyValues:dic];
                    [fruitslist_MiddleArray addObject:model];
                }
                [self.dataDic setObject:fruitslist_MiddleArray forKey:QFC_fruitslist];
            }
            
            //优享专区  hotlist
            NSArray *hotlistArray = [responseObject objectForKey:QFC_hotlist];
            if (hotlistArray.count) {
                NSMutableArray *hotlist_MiddleArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in hotlistArray) {
                    Home_CommunityNearby_Activity_Model *model = [Home_CommunityNearby_Activity_Model mj_objectWithKeyValues:dic];
                    [hotlist_MiddleArray addObject:model];
                }
                [self.dataDic setObject:hotlist_MiddleArray forKey:QFC_hotlist];
            }
            //尚品臻选  highlist
            NSArray *highlistArray = [responseObject objectForKey:QFC_highlist];
            if (highlistArray.count) {
                NSMutableArray *highlist_MiddleArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in highlistArray) {
                    Home_CommunityNearby_Activity_Model *model = [Home_CommunityNearby_Activity_Model mj_objectWithKeyValues:dic];
                    [highlist_MiddleArray addObject:model];
                }
                [self.dataDic setObject:highlist_MiddleArray forKey:QFC_highlist];
            }
            
            //特惠专区  discountlist
            NSArray *responseArray = [responseObject objectForKey:QFC_discountlist];
            if (responseArray.count) {
                NSMutableArray *response_MiddleArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in responseArray) {
                    Home_CommunityNearby_Activity_Model *model = [Home_CommunityNearby_Activity_Model mj_objectWithKeyValues:dic];
                    [response_MiddleArray addObject:model];
                }
                [self.dataDic setObject:response_MiddleArray forKey:QFC_discountlist];
            }
            [self.tableView reloadData];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

#pragma mark----HomeCommunityNearbyFirstEnjoyThreeCellDelegate
- (void)HomeCommunityNearbyFirstEnjoyThreeCellLiftImageClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
    
}

- (void)HomeCommunityNearbyFirstEnjoyThreeCellMiddleImageClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
- (void)HomeCommunityNearbyFirstEnjoyThreeCellRightImageClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

#pragma mark----HomeCommunityNearbyFreshFruitSinkThreeCellDelegate


- (void)HomeCommunityNearbyFreshFruitSinkThreeCellImageLiftClick:(nonnull NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)HomeCommunityNearbyFreshFruitSinkThreeCellMiddleImageClick:(nonnull NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)HomeCommunityNearbyFreshFruitSinkThreeCellRightImageClick:(nonnull NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

#pragma mark----HomeCommunityNearbyEspecialRegionThreeCellDelegate

- (void)HomeCommunityNearbyEspecialRegionThreeCellImageLiftClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)HomeCommunityNearbyEspecialRegionThreeCellMiddleImageClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}

- (void)HomeCommunityNearbyEspecialRegionThreeCellRightImageClick:(NSString *)goodsid {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
        VC.goodid = goodsid;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
}
@end
