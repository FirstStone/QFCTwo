//
//  Square_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_ViewController.h"

@interface Square_ViewController ()<ZXCategorySliderBarDelegate, ZXPageCollectionViewDelegate, ZXPageCollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) ZXPageCollectionView *pageVC;
@property (nonatomic, strong) ZXCategorySliderBar *sliderBar;
@property (strong, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UIButton *Right_BT;
@property (strong, nonatomic) UIScrollView *scrollView;


@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *Title_Array;
@end

@implementation Square_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadingDataSoure];
//    self.itemArray =@[@"推荐", @"话题", @"二手", @"租房", @"问答"];
//    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.itemArray];


    /*
    self.sliderBar.originIndex = 0;
    self.sliderBar.itemArray = self.itemArray;
    [self.view addSubview:self.sliderBar];
    [self.view addSubview:self.pageVC];
    self.sliderBar.moniterScrollView = self.pageVC.mainScrollView;
    UIButton * Right_BT = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button addTarget:self action:@selector(RightBTChange) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"icon_sousuo"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(RightBTClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:Right_BT];
    [Right_BT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(15.0f, 15.0f));
        make.centerY.equalTo(self.sliderBar.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-15.0f);
    }];*/
    
}
- (void)setUPUI {
    self.segmentedControl.sectionTitles = self.itemArray;
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = QFC_Color_30AC65;//[UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor] ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName :[UIFont systemFontOfSize:14.0f weight:UIFontWeightBold]};
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {// is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:YES];
    }];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.itemArray.count; i++) {
        Square_Tableview *LiftTableview = [[Square_Tableview alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) style:UITableViewStylePlain];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        LiftTableview.Style_id = [self.Title_Array[i] Title_ID];
        [LiftTableview beginFresh];
        [self.scrollView addSubview:LiftTableview];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}
- (NSMutableArray *)Title_Array {
    if (!_Title_Array) {
        _Title_Array = [[NSMutableArray alloc] init];
    }
    return _Title_Array;
}
- (ZXCategorySliderBar *)sliderBar
{
    if (!_sliderBar) {
        _sliderBar = [[ZXCategorySliderBar alloc]initWithFrame:CGRectMake(60.0f, is_IPhone_X ? 44.0f : 20.0f, SCREEN_WIDTH - 120.0f, 40.0f)];
        _sliderBar.delegate = self;
    }
    return _sliderBar;
}


- (ZXPageCollectionView *)pageVC
{
    if (!_pageVC) {
        _pageVC = [[ZXPageCollectionView alloc]initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f : 64.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83) : (SCREEN_HEIGHT - 64.0f - 49.0f))];
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        _pageVC.mainScrollView.bounces = NO;
    }
    return _pageVC;
}

- (NSInteger)numberOfItemsInZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView{
    return self.itemArray.count;
}

- (void)ZXPageViewDidScroll:(UIScrollView *)scrollView direction:(NSString *)direction{
    [self.sliderBar adjustIndicateViewX:scrollView direction:direction];
}

- (UIView *)ZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView
              viewForItemAtIndex:(NSInteger)index{
    NSString *reuseIdentifier = [NSString stringWithFormat:@"childView%ld", (long)index];
    Square_Tableview *childView1 = (Square_Tableview *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
    if (!childView1) {
        childView1 = [[Square_Tableview alloc]initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height)];
        childView1.reuseIdentifier = reuseIdentifier;
        childView1.My_NAVC = self.navigationController;
        childView1.index = index;
        
    }
    return childView1;
}

- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    NSLog(@"=====%s=====", __func__);
    //滚动结束后加载页面
    //    childVIew *cv = (childVIew *)view;
    //    if (cv.dataArray.count == 0) {
    //        [cv fetchData];
    //    }
    [self.sliderBar setSelectIndex:pageView.currentIndex];
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    self.sliderBar.isMoniteScroll = YES;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

- (void)didSelectedIndex:(NSInteger)index{
    [self.pageVC moveToIndex:index animation:NO];
}
- (IBAction)RightBTClick:(id)sender {
//    Square_HT_Details_Seach_VC *VC = [[Square_HT_Details_Seach_VC alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark----新框架搭建

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f: 64.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83.0f) : (SCREEN_HEIGHT - 64.0f - 44.0f))];
        _scrollView.backgroundColor = QFC_BackColor_Gray;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83.0f) : (SCREEN_HEIGHT - 64.0f - 44.0f));
        _scrollView.delegate = self;
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 83.0f) : (SCREEN_HEIGHT - 64.0f - 44.0f)) animated:NO];
    }
    return _scrollView;
}
//- (HMSegmentedControl *)segmentedControl {
//    if (!_segmentedControl) {
////        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f : 64.0f, SCREEN_WIDTH, 40.0f)];
//        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.itemArray];
////        _segmentedControl.sectionTitles = self.itemArray;
//        _segmentedControl.selectedSegmentIndex = 0;
//        _segmentedControl.backgroundColor = QFC_Color_30AC65;//[UIColor whiteColor];
//        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor] ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
//        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : QFC_Color_30AC65, NSFontAttributeName :[UIFont systemFontOfSize:14.0f weight:200.0f]};
//        _segmentedControl.selectionIndicatorColor = QFC_Color_30AC65;
//        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
//        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
//
//    }
//    return _segmentedControl;
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark----UPData

- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:@"0" forKey:@"typeid"];
    [parm setObject:@"1" forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_setType parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
         NSLog(@"%@", responseObject);
        if (responseObject) {
            for (NSDictionary *dic in responseObject) {
                SquareTitle_Model *model = [SquareTitle_Model mj_objectWithKeyValues:dic];
                [self.Title_Array addObject:model];
                [self.itemArray addObject:model.Type_name];
            }
            [self setUPUI];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

@end
