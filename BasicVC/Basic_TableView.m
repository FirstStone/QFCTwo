//
//  Basec_TableView.m
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "Basic_TableView.h"

@implementation Basic_TableView



- (void)endHeaderRefresh{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}
- (void)endRefresh{
    [self endHeaderRefresh];
    [self endFooterRefresh];
}

- (void)beginFresh {
    [self.mj_header beginRefreshing];
}

- (void)hidenFooterView:(BOOL)State {
    [self.emptyPlaceView hide];
    if (State) {
        [self configDefaultEmptyView];
        [self.emptyPlaceView showWithImgName:@"暂无内容" title:@"暂无数据" des:nil btnText:@"刷新" btnImg:nil tapClick:^{
            [self beginFresh];
        }];
//        [self.emptyPlaceView showWithImgName:@"暂无内容" title:@"暂无数据" des:Nil tapClick:^{
        
//        }];
    }else {
         [self.mj_footer endRefreshingWithNoMoreData];
    }
}
@end
