//
//  Home_CommunityNearby_Branch_ViewController.m
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Branch_ViewController.h"

@interface Home_CommunityNearby_Branch_ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *Title_Array;

@end

@implementation Home_CommunityNearby_Branch_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadingDataSoure];
}
- (IBAction)LiftButtonPOP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)setUPUI {
    [self.view addSubview:self.segmentedControl];
    __weak typeof(self)weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.itemArray.count; i++) {
        Home_CommunityNearby_Branch_CollectionView *LiftTableview = [[Home_CommunityNearby_Branch_CollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        LiftTableview.My_NAVC = self.navigationController;
        LiftTableview.index = i;
        LiftTableview.Type_ID = [self.Title_Array[i] Style_id];
        [LiftTableview LoadingDataSoure];
        [self.scrollView addSubview:LiftTableview];
    }
}

#pragma mark----懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f + 40.0f : 64.0f+ 40.0f, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f))];
        _scrollView.backgroundColor = QFC_BackColor_Gray;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.itemArray.count, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34- 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f));
        _scrollView.delegate = self;
        [_scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * self.Type, 0, SCREEN_WIDTH, is_IPhone_X ? (SCREEN_HEIGHT - 88.0f - 34 - 40.0f) : (SCREEN_HEIGHT - 64.0f - 40.0f)) animated:NO];
    }
    return _scrollView;
}
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, is_IPhone_X ? 88.0f : 64.0f, SCREEN_WIDTH, 40.0f)];
        _segmentedControl.sectionTitles = self.itemArray;
        _segmentedControl.selectedSegmentIndex = self.Type;
        _segmentedControl.backgroundColor = QFC_Color_F5F5F5;//[UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor] ,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : QFC_Color_30AC65, NSFontAttributeName :[UIFont systemFontOfSize:14.0f weight:200.0f]};
        _segmentedControl.selectionIndicatorColor = QFC_Color_30AC65;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        
        
    }
    return _segmentedControl;
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

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
                [self.Title_Array addObject:model];
                [self.itemArray addObject:model.Type_name];
            }
            [self setUPUI];
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"数据加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
