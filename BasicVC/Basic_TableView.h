//
//  Basec_TableView.h
//  QFC
//
//  Created by tiaoxin on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Basic_TableView : UITableView

- (void)endHeaderRefresh;

- (void)endFooterRefresh;
/**
 *  在reloadData之后调用
 */
- (void)endRefresh;

- (void)beginFresh;
- (void)hidenFooterView:(BOOL)State;
@property (nonatomic, assign) NSInteger Page;


@end

NS_ASSUME_NONNULL_END
