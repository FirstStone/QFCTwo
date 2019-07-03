//
//  Message_ApexView_TabelView.m
//  QFC
//
//  Created by tiaoxin on 2019/5/25.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Message_ApexView_TabelView.h"
#define CellID_MessageApexCell @"MessageApexCell"

@interface Message_ApexView_TabelView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Message_ApexView_TabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellAccessoryNone;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = QFC_BackColor_Gray;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([Message_ApexCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID_MessageApexCell];
        MJWeakSelf;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Page = 1;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf LoadingDataSoure];
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.Page += 1;
            [weakSelf LoadingDataSoure];
        }];
    }
    return self;
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
    Message_Apex_Model *model = self.dataArray[indexPath.row];
    Message_ApexCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID_MessageApexCell];
    [cell setDataSoureToCell:model type:self.index];
    return cell;
}

#pragma mark----UPdata
/**
 消息页面 获取顶一顶列表
 URL : https://www.txkuaiyou.com/index/Informations/infromList
 参数 :
 uid
 用户ID
 type
 1动态列表 2评论获取点赞列表
 page
 分页
 */
- (void)LoadingDataSoure {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setObject:[[NSUserDefaults standardUserDefaults] objectForKey:User_Mid] forKey:@"uid"];
    [parm setObject:self.index ? @"2" : @"1" forKey:@"type"];
    [parm setObject:@(self.Page) forKey:@"page"];
    [[HttpRequest sharedInstance] postWithURLString:URL_Informations_likelist parameters:parm success:^(NSDictionary * _Nonnull responseObject) {
         [self endRefresh];
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue]) {
            //获取list
            NSArray *list_Array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in list_Array) {
                Message_Apex_Model *model = [Message_Apex_Model mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (!list_Array.count) {
                [self hidenFooterView:NO];
            }else if (!self.dataArray.count){
                [self hidenFooterView:YES];
            }
            [self reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        [MBProgressHUD py_showError:@"加载失败" toView:nil];
        [MBProgressHUD setAnimationDelay:0.7f];
    }];
}



@end
