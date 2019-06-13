//
//  Square_Tableview.m
//  QFC
//
//  Created by tiaoxin on 2019/4/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Square_Tableview.h"

#define CellID_SquareDefaultCell @"SquareDefaultCell"
#define CellID_SquareShopCell @"SquareShopCell"
#define CellID_SquareTextCell @"SquareTextCell"
#define CellID_SquareESHeaderCell @"SquareESHeaderCell"
#define CellID_SquareHTImageCell @"SquareHTImageCell"
#define CellID_SquareHTTextCell @"SquareHTTextCell"
#define CellID_SquareWDImageCell @"SquareWDImageCell"
#define CellID_SquareWDQuestionCell @"SquareWDQuestionCell"
#define CellID_SquareWDTextCell @"SquareWDTextCell"
#define CellID_SquareWDImageAndTextCell @"SquareWDImageAndTextCell"
#define CellID_SquareWDSDCell @"SquareWDSDCell"

@interface Square_Tableview ()<UITableViewDelegate, UITableViewDataSource, SquareDefaultCellDelegate, SquareHTImageCellDelegate, SquareWDTextCellDelegate, SquareTextCellDelegate, SquareHTTextCellDelegate, SquareWDQuestionCellDelegate, SquareWDImageAndTextCellDelegate>

@property (nonatomic, strong) NSMutableArray *SquareRecommend_Array;

@end

@implementation Square_Tableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self != nil) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_Default_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareDefaultCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_Shop_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareShopCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_TextCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareTextCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_ES_Header_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareESHeaderCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTImageCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_HT_Text_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareHTTextCell];
         [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_ImageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDImageCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_Question_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDQuestionCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_Text_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDTextCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_ImageAndText_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDImageAndTextCell];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Square_WD_SD_Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_SquareWDSDCell];
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.SquareRecommend_Array removeAllObjects];
            [weakSelf LoadingDataSoure];
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.index < 4) {
                weakSelf.Page += 1;
                [weakSelf LoadingDataSoure];
            }else {
                [weakSelf getgetDataSourePlazaanswersMoreList];
            }
        }];
    }
    return self;
}

- (NSMutableArray *)SquareRecommend_Array {
    if (!_SquareRecommend_Array) {
        _SquareRecommend_Array = [[NSMutableArray alloc] init];
        if(self.index == 2 || self.index == 3) {
            [_SquareRecommend_Array addObject:[[SquareRecommend_Model alloc] init]];
        }
    }
    return _SquareRecommend_Array;
}
#pragma mark - UITableViewDelegate
//返回多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//返回一个分区里多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.SquareRecommend_Array.count;
}
// 返回Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--------------------%ld, %ld", self.SquareRecommend_Array.count, self.index);
    if (self.index == 4) {//问答
        if (indexPath.row == 0) {//头部
            Square_info_Model *model = self.SquareRecommend_Array[indexPath.row];
            Square_WD_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageCell];
            [cell setModelToCell:model];
            return cell;
        }else if (indexPath.row == 1) {//轮播图
            Square_WD_SD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDSDCell];
            [cell setModelToCell:self.SquareRecommend_Array[indexPath.row]];
            return cell;
        }else {
            if([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_address_Model class]]) {
                Square_address_Model *model = self.SquareRecommend_Array[indexPath.row];
                Square_WD_Question_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDQuestionCell];
                [cell setModelToCell:model];
                cell.delegate = self;
                return cell;
            }else {
                Square_WD_Model *model = self.SquareRecommend_Array[indexPath.row];
                if ([model.type intValue] == 1) {//标题回答无图片
                    Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
                    [cell setSquareWDModelToCell:model];
                    cell.delegate = self;
                    return cell;
                }else if ([model.type intValue] == 2){//标题回答图片
                    Square_WD_ImageAndText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageAndTextCell];
                    [cell setSquareWDModelToCell:model];
                    cell.delegate = self;
                    return cell;
                }else {//没有回答，只有标题
                    Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
                    [cell setSquareWDModelToCell:model];
                    cell.delegate = self;
                    return cell;
                }
            }
        }
        
        
       /* if (indexPath.row == 0) {
            Square_WD_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageCell];
            return cell;
        }else if (indexPath.row == 1){
            Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
            return cell;
        }else if (indexPath.row == 2) {
            Square_WD_SD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDSDCell];
            return cell;
        }else if (indexPath.row == 3) {
            Square_WD_ImageAndText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDImageAndTextCell];
            return cell;
        } else {
            Square_WD_Question_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDQuestionCell];
            return cell;
        }*/
        
        
    }else if (self.index == 3) {//租房
        if (indexPath.row == 0) {
            Square_ES_Header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareESHeaderCell];
            [cell setDataSoureTocell];
            return cell;
        }else {
            SquareRecommend_Model *model = self.SquareRecommend_Array[indexPath.row];
            if ([model.status intValue] == 2) {//加图片
                Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
                cell.delegate = self;
                [cell setDataSoureToCell:model];
                return cell;
            } else if ([model.status intValue] == 3){//问答
                Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
                [cell setDataSoureToCell:model];
                cell.delegate = self;
                return cell;
            }else {//文字
                Square_HT_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTTextCell];
                [cell setDataSoureToCell:model];
                cell.delegate = self;
                return cell;
            }
        }
        /*if (indexPath.row == 0) {
            Square_ES_Header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareESHeaderCell];
            [cell setDataSoureTocell];
            return cell;
        }else if (indexPath.row == 1) {
            Square_Default_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareDefaultCell];
            return cell;
        }else {
            Square_Default_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareDefaultCell];
            return cell;
        }*/
    }else if (self.index == 1) {//话题
        SquareRecommend_Model *model = self.SquareRecommend_Array[indexPath.row];
        if ([model.status intValue] == 2) {//加图片
            Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            cell.delegate = self;
            [cell setDataSoureToCell:model];
            return cell;
        } else if ([model.status intValue] == 3){//问答
            Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
            [cell setDataSoureToCell:model];
            cell.delegate = self;
            return cell;
        }else {//文字
            Square_HT_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTTextCell];
            [cell setDataSoureToCell:model];
            cell.delegate = self;
            return cell;
        }
    }else if (self.index == 2) {//二手
        if (indexPath.row == 0) {
            Square_ES_Header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareESHeaderCell];
            return cell;
        }else {
            SquareRecommend_Model *model = self.SquareRecommend_Array[indexPath.row];
            if ([model.status intValue] == 2) {//加图片
                Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
                cell.delegate = self;
                [cell setDataSoureToCell:model];
                return cell;
            } else if ([model.status intValue] == 3){//问答
                Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
                [cell setDataSoureToCell:model];
                cell.delegate = self;
                return cell;
            }else {//文字
                Square_HT_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTTextCell];
                [cell setDataSoureToCell:model];
                 cell.delegate = self;
                return cell;
            }
        }

        /*if (indexPath.row == 0) {
            Square_ES_Header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareESHeaderCell];
            if (!cell) {
                
            }
            
            return cell;
        } else {
            Square_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareShopCell];
            if (!cell) {
                
            }
            
            return cell;
        }*/
    }else {//推荐
        SquareRecommend_Model *model = self.SquareRecommend_Array[indexPath.row];
        if ([model.status intValue] == 3) {//问答
             Square_WD_Text_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareWDTextCell];
            cell.delegate = self;
            [cell setDataSoureToCell:model];
            return cell;
        }else if ([model.status intValue] == 2){//加图片
             Square_HT_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareHTImageCell];
            cell.delegate = self;
            [cell setDataSoureToCell:model];
            return cell;
        }else {//文字
            Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
            [cell setDataSoureToCell:model];
            cell.delegate = self;
            return cell;
        }
        /*
         if (indexPath.row == 3) {
         Square_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareShopCell];
         if (!cell) {
         
         }
         
         return cell;
         }else if (indexPath.row == 2) {
         Square_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareTextCell];
         if (!cell) {
         
         }
         
         return cell;
         } else {
         Square_Default_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_SquareDefaultCell];
         cell.delegate = self;
         return cell;
         }
         */
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[SquareRecommend_Model class]]) {
        SquareRecommend_Model *model = self.SquareRecommend_Array[indexPath.row];
        if ([model.status intValue] == 3) {//问答
            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
            [QAVC setHidesBottomBarWhenPushed:YES];
            QAVC.item_id = model.SquareRecommend_ID;
            QAVC.uid = model.uid;
            [self.My_NAVC pushViewController:QAVC animated:YES];
        }else {
            Square_HT_Details_VC *detailsVC = [[Square_HT_Details_VC alloc] init];
            detailsVC.item_id = model.SquareRecommend_ID;
            [detailsVC setHidesBottomBarWhenPushed:YES];
            [self.My_NAVC pushViewController:detailsVC animated:YES];
        }
    }else {
        if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_info_Model class]]) {//头部第一个
            Square_info_Model *model = self.SquareRecommend_Array[indexPath.row];
            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
            [QAVC setHidesBottomBarWhenPushed:YES];
            QAVC.item_id = model.info_id;
            QAVC.uid = @"0";
            [self.My_NAVC pushViewController:QAVC animated:YES];
        }else if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_address_Model class]]) {//地址
            Square_address_Model *model = self.SquareRecommend_Array[indexPath.row];
            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
            [QAVC setHidesBottomBarWhenPushed:YES];
            QAVC.item_id = model.address_id;
            QAVC.uid = model.uid;
            [self.My_NAVC pushViewController:QAVC animated:YES];
        }else if ([self.SquareRecommend_Array[indexPath.row] isMemberOfClass:[Square_WD_Model class]]) {//普通
            Square_WD_Model *model = self.SquareRecommend_Array[indexPath.row];
            Square_QuestionsAndAnswersVC *QAVC = [[Square_QuestionsAndAnswersVC alloc] init];
            [QAVC setHidesBottomBarWhenPushed:YES];
            QAVC.item_id = model.WD_id;
            QAVC.uid = model.uid;
            [self.My_NAVC pushViewController:QAVC animated:YES];
        }
    }
}

#pragma mark----SquareDefaultCellDelegate
- (void)iconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareWDTextCellDelegate
-(void)SquareWDTextCellIconView:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareTextCellDelegate
- (void)SquareTextCellIconViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareHTTextCellDelegate
- (void)SquareHTTextCellIconImageViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareWDQuestionCellDelegate
- (void)SquareWDQuestionCellIconimageViewClick:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareWDImageAndTextCellDelegate
- (void)SquareWDImageAndTextCellIconimage:(NSString *)mid {
    Square_Prsonal_Details_VC *preVC  = [[Square_Prsonal_Details_VC alloc] init];
    preVC.uid = mid;
    [preVC setHidesBottomBarWhenPushed:YES];
    [self.My_NAVC pushViewController:preVC animated:YES];
}

#pragma mark----SquareHTImageCellDelegate

- (void)SquareHTImageCellButtonClick:(NSInteger)index SquareRecommendModel:(SquareRecommend_Model *)model {
    if (index == 1) {//顶
        [self setPraiseToBacker:model.SquareRecommend_ID];
    }
}




#pragma mark----UPdata

- (void)setPraiseToBacker:(NSString *)state {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:state forKey:@"plazaid"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Plazas_plazaLike parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            [MBProgressHUD py_showError:@"操作成功" toView:nil];
            [MBProgressHUD setAnimationDelay:0.7f];
            [self LoadingDataSoure];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"操作失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


- (void)LoadingDataSoure {
    if (self.index < 4) {
        [self getDataSoureNomel];
    }else {
        [self getDataSourePlazaanswers];
    }
}

- (void)getgetDataSourePlazaanswersMoreList {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_plazaanswers parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Square_WD_Model *model = [Square_WD_Model mj_objectWithKeyValues:dic];
                [self.SquareRecommend_Array addObject:model];
            }
            if (self.SquareRecommend_Array.count && self.Page == 1) {
                [self hidenFooterView:NO];
            }else {
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)getDataSourePlazaanswers {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazas_plazaanswers parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取info
            NSArray *info_Array = [responseObject objectForKey:@"info"];
            for (NSDictionary *dic in info_Array) {
                Square_info_Model *model = [Square_info_Model mj_objectWithKeyValues:dic];
                [self.SquareRecommend_Array addObject:model];
            }
            //获取carousel
            NSArray *carousel_Array = [responseObject objectForKey:@"carousel"];
            NSMutableArray *Middle_Array = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in carousel_Array) {
                Square_carousel_Model *model = [Square_carousel_Model mj_objectWithKeyValues:dic];
                [Middle_Array addObject:model];
            }
            [self.SquareRecommend_Array addObject:Middle_Array];
            //获取address
            NSArray *address_Array = [responseObject objectForKey:@"address"];
            for (NSDictionary *dic in address_Array) {
                Square_address_Model *model = [Square_address_Model mj_objectWithKeyValues:dic];
                [self.SquareRecommend_Array addObject:model];
            }
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Square_WD_Model *model = [Square_WD_Model mj_objectWithKeyValues:dic];
                [self.SquareRecommend_Array addObject:model];
            }
            if (!list_Array.count) {
                [self hidenFooterView:NO];
            }else if (!self.SquareRecommend_Array.count){
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}

- (void)getDataSoureNomel {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:User_Mid]) {
        [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    }else {
        [parm setObject:@"0" forKey:@"uid"];
    }
    [parm setObject:self.Style_id forKey:@"typeid"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_plazaList parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
        [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            NSArray *Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in Array) {
                SquareRecommend_Model *model = [SquareRecommend_Model mj_objectWithKeyValues:dic];
                [self.SquareRecommend_Array addObject:model];
            }
            if (!Array.count) {
                [self hidenFooterView:NO];
            }else if (!self.SquareRecommend_Array.count){
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}


@end
