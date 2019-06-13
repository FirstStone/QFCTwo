//
//  Home_CommunityNearby_Branch_CollectionView.m
//  QFC
//
//  Created by tiaoxin on 2019/5/13.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Home_CommunityNearby_Branch_CollectionView.h"
#define CellID_HomeCommunityNearbyBranchCollectionViewCell @"HomeCommunityNearbyBranchCollectionViewCell"

@interface Home_CommunityNearby_Branch_CollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
@implementation Home_CommunityNearby_Branch_CollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Home_CommunityNearby_Branch_CollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellID_HomeCommunityNearbyBranchCollectionViewCell];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = QFC_Color_F5F5F5;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


#pragma mark-----UICollectionViewDelegate
//每一组section有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//返回多少个Sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Home_CommunityNearby_Branch_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID_HomeCommunityNearbyBranchCollectionViewCell forIndexPath:indexPath];
    [cell setModelToCell:self.dataArray[indexPath.row]];
    return cell;
}
//设置item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 30.0f)/2.0f, 220.0f);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20.0f, 10.0f, 10.0f, 10.0f);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

//每个item 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Home_CommunityNearby_ActivityBranch_Model *model = self.dataArray[indexPath.row];
    Home_CommunityNearby_Branch_Details_VC *VC = [[Home_CommunityNearby_Branch_Details_VC alloc] init];
    VC.goodid = model.Branch_id;
    [VC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:VC animated:YES];
}

#pragma mark----UPdata
/**
 //周边商城分类列表
 Route::rule('goodstypelist/:uid/:page/:type','index/Goodss/goodsTypeList');
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:@"1" forKey:@"page"];
    [parm setObject:self.Type_ID forKey:@"type"];
    [[HttpRequest sharedInstance] postWithURLString:URL_goodsTypeList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                Home_CommunityNearby_ActivityBranch_Model *model = [Home_CommunityNearby_ActivityBranch_Model  mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self reloadData];
            if (!Array.count) {
                [self configDefaultEmptyView];
                [self.emptyPlaceView showWithImgName:@"暂无内容" title:@"暂无数据" des:Nil tapClick:^{
                    
                }];
            }
        }else {
            [MBProgressHUD py_showError:@"暂无数据" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}




@end
