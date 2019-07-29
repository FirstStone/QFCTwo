//
//  Home_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_ViewController.h"

#define CellID_CommunityActivities @"HomeCommunityActivitiesCell"
#define CellID_HomePreferentialCell @"HomePreferentialCell"
#define CellID_HomeRecommendCell @"HomeRecommendCell"
#define CellID_HomeCommunityHotSearchCell @"HomeCommunityHotSearchCell"

#define CellID_HomeShopStoreCell @"HomeShopStoreCell"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
@interface Home_ViewController ()<FMHorizontalMenuViewDelegate,FMHorizontalMenuViewDataSource,SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, AMapLocationManagerDelegate, UISearchBarDelegate, PYSearchViewControllerDelegate, PYSearchViewControllerDataSource, TLCityPickerDelegate>
@property (weak, nonatomic) IBOutlet Basic_TableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;

@property (strong, nonatomic) IBOutlet UIButton *Address_BT;


@property (nonatomic, strong) UILabel *TextLabel;

@property (nonatomic,strong) FMHorizontalMenuView *menuView;

@property (nonatomic, strong) SDCycleScrollView *sdcscrollView;

@property (nonatomic, strong) SDCycleScrollView *TextSDCscrollView;

@property (nonatomic, strong) NSArray *Icon_Array;
@property (nonatomic, strong) NSArray *Title_Array;


@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *hotTopArray;

@property(nonatomic,strong)PYSearchViewController *searchViewController;

@property (nonatomic, strong) Home_SearchResult_ViewContraller *searchResultVC;

@end

@implementation Home_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initCompleteBlock];
    [self configLocationManager];
    [self setUPUIMapView];
//    self.view.backgroundColor = QFC_Color_Green;
//    self.navigationController.delegate = self;
    //定位
//    self.locationManager = [[AMapLocationManager alloc] init];
//    self.locationManager.delegate = self;
////    self.locationManager.distanceFilter;
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateApp) name:@"VersionAPP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUPUIMapView) name:@"setUPUIMapView" object:nil];
    [self updateApp];
    self.Icon_Array = @[@"icon_zhekou", @"icon_paotui", @"icon_jiazheng", @"icon_Daireng"];// , @"icon_ershou", @"icon_zhaofang"
    self.Title_Array = @[@"优享生鲜", @"快友跑腿", @"便民家政", @"快代扔"];//, @"跳蚤市场", @"友友找房"
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityActivities_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_CommunityActivities];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_PreferentialCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomePreferentialCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_RecommendCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeRecommendCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityHotSearchCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeCommunityHotSearchCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Home_ShopStore_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_HomeShopStoreCell];
    [self setUPUI];
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
    [self.tableView beginFresh];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)hotTopArray {
    if (!_hotTopArray) {
        _hotTopArray = [[NSMutableArray alloc] init];
    }
    return _hotTopArray;
}

//self.navigationController.delegate = self;
//#pragma mark----UINavigationController?Delegate
////将要显示的控制器是否是自己
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    //判断要显示的控制器是否是自己
//    BOOL isShowHomePagge = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePagge animated:YES];
//}
//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.tintColor = QFC_Color_Green;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self loadingHotTopDataSoure];
    [self.tableView beginFresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
    
}

- (IBAction)AddressButtonClick:(id)sender {
    [self goToChooseCity];
}

- (void)setUPUI{
    self.SearchBar.delegate = self;
    [self.SearchBar setImage:[UIImage imageNamed:@"icon_sousuo"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [self.SearchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = QFC_Color_97CFA9;
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    searchField.textAlignment = NSTextAlignmentCenter;
    UIView *tableViewHeaderView = [self getTableViewHeadView];
    tableViewHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 475.0f);
    self.tableView.tableHeaderView = tableViewHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (UIView *)getTableViewHeadView {
    UIView *contView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    UIImageView *back_imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"Home_back_image"];
        imageView.userInteractionEnabled = YES;
        imageView;
    });
    [contView addSubview:back_imageView];
    [back_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contView);
        make.height.offset(180.0f);
    }];
    
    //附近快友 头像 右箭头
    UIView *Right_View = ({
        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor orangeColor];
        view;
    });
    [back_imageView addSubview:Right_View];
    
    UIImageView *Right_imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_Right"];
        imageView;
    });
    [Right_View addSubview:Right_imageView];
    
    UIImageView *Middle_imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_Photo"];
        imageView;
    });
    [Right_View addSubview:Middle_imageView];
    [Right_View addSubview:self.TextLabel];
    [back_imageView addSubview:Right_View];
    [Right_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(Right_View);
        make.right.equalTo(Right_View.mas_right).offset(-10.0f);
        make.width.equalTo(Right_View.mas_height);
    }];
    [Middle_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Right_imageView.mas_left).offset(-5.0f);
        make.top.bottom.equalTo(Right_View);
        make.width.equalTo(Right_View.mas_height);
    }];
    [self.TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(Right_View);
        make.right.equalTo(Middle_imageView.mas_left).offset(-5.0f);
    }];
    [Right_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(back_imageView.mas_right);
        make.height.mas_offset(25.0f);
        make.left.equalTo(self.TextLabel.mas_left);
        make.bottom.equalTo(back_imageView.mas_bottom).offset(-33.0f);
    }];
    
    UIView *Down_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 30.0f;
        view;
    });
    [contView addSubview:Down_View];
    [Down_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.top.equalTo(back_imageView.mas_bottom).offset(-25.0f);
//        make.bottom.equalTo(contView.mas_bottom);
        make.height.offset(249);
    }];
    
    //动画样式
    self.menuView = [[FMHorizontalMenuView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.menuView.currentPageDotColor = [UIColor colorWithRed:67 / 255.0 green:207 / 255.0 blue:119 / 255.0 alpha:0];
    self.menuView.pageDotColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.menuView.pageControlStyle = FMHorizontalMenuViewPageControlStyleNone;
//    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.hidesForSinglePage = NO;
    [Down_View addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Down_View);
        make.left.right.equalTo(Down_View);
        make.height.mas_offset(100.0f);
    }];
    
    [self.menuView reloadData];
    
    [Down_View addSubview:self.sdcscrollView];
    [self.sdcscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(Down_View);
        make.top.equalTo(self.menuView.mas_bottom);
    }];
    //底部灰色背景
    UIView *Down_Hui_View = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = QFC_BackColor_Gray;
        view;
    });
    [contView addSubview:Down_Hui_View];
    [Down_Hui_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.top.equalTo(self.sdcscrollView.mas_bottom);
        make.height.offset(75.0f);
    }];
    //底部灰色背景->白色
    UIView *Down_Hui_WhierBackView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 27.5f;
        view;
    });
    //图片
    UIImageView *Down_Hui_Whier_imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_Shangqiang"];
        imageView;
    });
    //底部灰色轮播
    
    [Down_Hui_View addSubview:Down_Hui_WhierBackView];
    [Down_Hui_WhierBackView addSubview:Down_Hui_Whier_imageView];
    [Down_Hui_WhierBackView addSubview:self.TextSDCscrollView];
    
    
    
    
    
    [Down_Hui_WhierBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Down_Hui_View).insets(UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
    }];
    [Down_Hui_Whier_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(33.0f, 30.0f));
        make.left.equalTo(Down_Hui_WhierBackView.mas_left).offset(16.0f);
        make.top.equalTo(Down_Hui_WhierBackView.mas_top).offset(16.0f);
    }];
    [self.TextSDCscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Down_Hui_Whier_imageView.mas_right).offset(15.0f);
        make.top.equalTo(Down_Hui_WhierBackView.mas_top).offset(6.0f);
        make.right.equalTo(Down_Hui_WhierBackView.mas_right).offset(-7.0f);
        make.bottom.equalTo(Down_Hui_WhierBackView.mas_bottom).offset(-6.0f);
    }];
    
    
    return contView;
}


-(void)goToChooseCity
{
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    
    [cityPickerVC setDelegate:self];
    
    // 设置定位城市
    cityPickerVC.locationCityID = @"200010000";
    
    // 最近访问城市，如果不设置，将自动管理
    //  cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];
    
    // 热门城市，需手动设置
    cityPickerVC.hotCitys = @[@"200010000"];
    
    // 支持push、present方式跳入，但需要有UINavigationController
    [self.navigationController setNavigationBarHidden:NO];
    [cityPickerVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cityPickerVC animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark----TLCityPickerDelegate
- (void)cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city {
    [self.tableView beginFresh];
    [self.Address_BT setTitle:city.cityName forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark----UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self goToSearchVC:self.hotTopArray];
    return NO;
}

-(void)goToSearchVC:(NSArray *)hotDataArry;
{
    //    UIButton * backBT= ({
    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [button setImage:[UIImage imageNamed:@"icon_Lift"] forState:UIControlStateNormal];
    //        button;
    //    });
    //    _searchViewController.lif
    // 2. 创建搜索控制器
    MJWeakSelf
    _searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotDataArry searchBarPlaceholder:@"搜索你想要的" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        weakSelf.searchResultVC = [[Home_SearchResult_ViewContraller alloc] init];
        //        _searchResultVC.searchTypeArry = _typeArry;
        //        _searchResultVC.VCtag = 0;
        
        weakSelf.searchResultVC.SearcgText = searchText;
        weakSelf.searchViewController.searchResultController = weakSelf.searchResultVC;
        weakSelf.searchViewController.searchResultShowMode = PYSearchResultShowModeEmbed;
        //        weakSelf.searchViewController.searchSuggestionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f);
        // 开始(点击)搜索时执行以下代码
    }];
    //     设置热门搜索为彩色标签风格
    _searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
//    [_searchViewController.backButton setImage:[UIImage imageNamed:@"icon_HT_XiangQing_Zuo"] forState:UIControlStateNormal];
    _searchViewController.cancelButton.hidden = YES;
    _searchViewController.delegate = self;
    _searchViewController.dataSource = self;
    _searchViewController.searchSuggestionHidden = NO;
    _searchViewController.cancelButton.py_width = 40.0f;
    self.navigationController.navigationBar.tintColor = QFC_Color_30AC65;
    self.navigationController.navigationBar.backgroundColor = QFC_Color_30AC65;
    self.navigationController.navigationBar.barTintColor = QFC_Color_30AC65;
    self.navigationController.navigationBarHidden = NO;
    UIButton * BackBT = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"icon_HT_XiangQing_Zuo"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchButtonBack) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 40.0f, 40.0f);
        button;
    });
    UIView *leftCustomView = [[UIView alloc] initWithFrame:BackBT.frame];
    [leftCustomView addSubview:BackBT];
    _searchViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
    [_searchViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_searchViewController animated:NO];
    [self.SearchBar endEditing:YES];
}

- (void)searchButtonBack {
    [self.navigationController popViewControllerAnimated:YES];
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
    return 1;
}

/**
 设置每页的列数 默认 4
 
 @param horizontalMenuView 当前控件
 @return 列数
 */
-(NSInteger)numOfColumnsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 5;
}
/**
 当选项被点击回调
 
 @param horizontalMenuView 当前控件
 @param index 点击下标
 */
-(void)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView didSelectItemAtIndex:(NSInteger)index{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您点击了第%ld个",index + 1] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] intValue]) {
        if (index == 0) {
            Home_CommunityNearby_ViewController *CommunityNearbyVC = [[Home_CommunityNearby_ViewController alloc] init];
            [CommunityNearbyVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:CommunityNearbyVC animated:YES];
        } else if (index == 1) {
            Home_RunErrands_ViewController *runVC = [[Home_RunErrands_ViewController alloc] init];
            [runVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:runVC animated:YES];
        }else if (index == 2) {
            Home_HouseKeeping_ViewController *houseVC = [[Home_HouseKeeping_ViewController alloc] init];
            [houseVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:houseVC animated:YES];
        }else if (index == 3) {
            Home_KDR_ViewController *KDRVC = [[Home_KDR_ViewController alloc] init];
            [KDRVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:KDRVC animated:YES];
        } else {
            [MBProgressHUD py_showError:@"功能暂未开通" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    }else {
        Basic_NavigationController *LoginVC = [[Basic_NavigationController alloc] initWithRootViewController:[[Login_PhoneCodeViewControlloer alloc] init]];
        [self.navigationController presentViewController:LoginVC animated:YES completion:Nil];
    }
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
 本地图片
 
 @param horizontalMenuView 当前控件
 @param index 下标
 @return 图片名称
 */
-(NSString *)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView localIconStringForItemAtIndex:(NSInteger)index{
    return self.Icon_Array[index];
}
-(CGSize)iconSizeForHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return CGSizeMake(45, 45);
}

#pragma mark----懒加载
- (UILabel *)TextLabel {
    if (!_TextLabel) {
        _TextLabel = [[UILabel alloc] init];
        _TextLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _TextLabel.textColor = [UIColor whiteColor];
        _TextLabel.text = @"附近有48585位快友";
    }
    return _TextLabel;
}

- (SDCycleScrollView *)sdcscrollView {
    if (!_sdcscrollView) {
        _sdcscrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 150) imageURLStringsGroup:@[@"https://www.txkuaiyou.com/uploads/images/20190615192428.png", @"https://www.txkuaiyou.com/uploads/images/20190615192440.png", @"https://www.txkuaiyou.com/uploads/images/20190615192445.png"]];
        _sdcscrollView.showPageControl = YES;
        _sdcscrollView.pageControlDotSize = CGSizeMake(13.0f, 3.0f);
        _sdcscrollView.currentPageDotColor = QFC_Color(233,233,233);
        _sdcscrollView.pageDotColor = QFC_Color(48,172,101);
    }
    return _sdcscrollView;
}

- (SDCycleScrollView *)TextSDCscrollView {
    if (!_TextSDCscrollView) {
        _TextSDCscrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 6.0f, SCREEN_WIDTH, 43.0f) delegate:self placeholderImage:nil];//[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 6.0f, SCREEN_WIDTH, 43.0f) imageNamesGroup:nil];
        _TextSDCscrollView.onlyDisplayText = YES;
        _TextSDCscrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSMutableArray *titleArray = [NSMutableArray new];
        [titleArray addObject:@"[公益] 关注小区流浪动物，请给动物们一个家"];
        [titleArray addObject:@"[活动] 到底是谁发明出国这件孤独的事儿"];
        _TextSDCscrollView.titlesGroup = [titleArray copy];
        _TextSDCscrollView.showPageControl = NO;
        [_TextSDCscrollView disableScrollGesture];
        _TextSDCscrollView.layer.cornerRadius = 21.5f;
        _TextSDCscrollView.layer.masksToBounds = YES;
        _TextSDCscrollView.backgroundColor = QFC_BackColor_Gray;
        _TextSDCscrollView.tag = 59695884;
    }
    return _TextSDCscrollView;
}

#pragma mark-SDCycleScrollViewDelegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    if (view.tag == 59695884) {
        return [Home_ShangQiang_CollectionViewCell class];
    }else {
        return nil;
    }
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    if (view.tag == 59695884) {
        Home_ShangQiang_CollectionViewCell *myCell = (Home_ShangQiang_CollectionViewCell *)cell;
        NSMutableAttributedString *First_Str = [[NSMutableAttributedString alloc] initWithString:@"[公益] 关心世界，更关心你"];
        // 改变颜色
        [First_Str addAttribute:NSForegroundColorAttributeName value:QFC_Color(48,172,101) range:NSMakeRange(0, 4)];
        [myCell.Public_Label setAttributedText:First_Str];
        
        
        NSMutableAttributedString *second_Str = [[NSMutableAttributedString alloc] initWithString:@"[活动] “火种计划——商家扶持”"];
        // 改变颜色
        [second_Str addAttribute:NSForegroundColorAttributeName value:QFC_Color(48,172,101) range:NSMakeRange(0, 4)];
        [myCell.Activity_Label setAttributedText:second_Str];
    }
    
}
- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view {
    return [UINib nibWithNibName:NSStringFromClass([Home_ShangQiang_CollectionViewCell class]) bundle:[NSBundle mainBundle]];
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
    Home_ShopStore_Model *model = self.dataArray[indexPath.row];
    Home_ShopStore_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeShopStoreCell];
    [cell SetDataSoureToCell:model];
    return cell;
    
    /*    if (indexPath.row == 0) {
     Home_CommunityActivities_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_CommunityActivities];
     if (!cell) {
     
     }
     return cell;
     }
     if (indexPath.row == 0){
     Home_PreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomePreferentialCell];
     if (!cell) {
     
     }
     return cell;
     } else {// (indexPath.row == 1)
     Home_RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeRecommendCell];
     if (!cell) {
     
     }
     return cell;
     }
     else {
     Home_CommunityHotSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_HomeCommunityHotSearchCell];
     if (!cell) {
     
     }
     return cell;
     }*/
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Home_ShopStore_Model *model = self.dataArray[indexPath.row];
    Home_ShopStore_ViewController *ShopStoreVC = [[Home_ShopStore_ViewController alloc] init];
    ShopStoreVC.Shopid = model.Shop_id;
    [ShopStoreVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ShopStoreVC animated:YES];
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

//检测app更新
-(void)updateApp
{
    //1.先获取当前工程项目版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    
    //2.从网络获取appStore版本号
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //2.1没有内容
        if (data == nil) {
            NSLog(@"你没有连接网络哦");
            return;
        }
        //3.序列化解析
        NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        //3.1数据错误
        if (error) {
            NSLog(@"hsUpdateAppError:%@",error);
            return;
        }
        //3.2字典解析
        NSArray *array = appInfoDic[@"results"];
        NSString *appStoreVersion = @"1.0";
        if (array.count) {
            NSDictionary *dic = array[0];
            appStoreVersion = dic[@"version"];
        }
        
        
        //打印版本号
        NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
        
        //4.当前版本号小于商店版本号,就更新
        if([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending)
        {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"请更新最新版本" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIApplication *application = [UIApplication sharedApplication];
                NSString *APPStoreURL = @"https://itunes.apple.com/cn/app/id1461455050";
                if (@available(iOS 10.0, *)) {
                    [application openURL:[NSURL URLWithString:APPStoreURL] options:@{} completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                }
            }];
            [alertVC addAction:camera];
            [self presentViewController:alertVC animated:YES completion:nil];
            //            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"请更新最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            alertView.tag = 2;
            //            alertView.delegate = self;
            //            [alertView show];
            
        }else{
            NSLog(@"检测到不需要更新");
        }
    }];
    [dataTask resume];
}


#pragma mark----定位

- (void)setUPUIMapView {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        //定位功能可用
        //进行单次带逆地理定位请求
        //        [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
        [self.locationManager startUpdatingLocation];
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有定位权限，去设置" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //成功返回Block
            //打开app定位设置
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:settingsURL];
        }];
        [alertV addAction:okAction];
        [self presentViewController:alertV animated:YES completion:nil];
    }
}

- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    //    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    //    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    [self.locationManager setLocatingWithReGeocode:YES];
}

- (void)initCompleteBlock
{
    __weak Home_ViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        //修改label显示内容
        if (regeocode) {
            [Singleton sharedSingleton].formattedAddress = regeocode.formattedAddress;
            [Singleton sharedSingleton].City = regeocode.city;
            [weakSelf.Address_BT setTitle:regeocode.city forState:UIControlStateNormal];
        }
        if (location) {
            [Singleton sharedSingleton].latitude = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
            [Singleton sharedSingleton].longitude = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
        }
    };
}
#pragma mark - AMapLocationManager Delegate
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
//{
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    //    if (reGeocode)
    //    {
    //        NSLog(@"reGeocode:%@", reGeocode);
    //    }
    if (reGeocode) {
        [Singleton sharedSingleton].formattedAddress = reGeocode.formattedAddress;
        [Singleton sharedSingleton].City = reGeocode.city;
        [self.Address_BT setTitle:reGeocode.city forState:UIControlStateNormal];
    }
    if (location) {
        [Singleton sharedSingleton].latitude = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
        [Singleton sharedSingleton].longitude = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}

#pragma mark----UPdata
- (void)LoadingDataSoure {
    /**
     index/merchants/rimMerchantList
     uid   没有传空
     page
     获取周边商家列表
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@(self.tableView.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_merchants_rimMerchantList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self.tableView endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_ShopStore_Model *model = [Home_ShopStore_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!Array.count) {
                [self.tableView hidenFooterView:NO];
            }
        }
        if (!self.dataArray.count && self.tableView.Page == 1) {
            [self.tableView hidenFooterView:YES];
        }
        if (self.dataArray.count) {
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [self.tableView reloadData];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)loadingHotTopDataSoure {
    /**
     首页全局搜索 获取热门搜索列表
     URL : https://www.txkuaiyou.com/index/Search/HotSearch
     参数 :
     type
     1
     */
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:@"1" forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Search_HotSearch parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            [self.hotTopArray removeAllObjects];
            for (NSString *HotStr in Array) {
                [self.hotTopArray addObject:HotStr];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
