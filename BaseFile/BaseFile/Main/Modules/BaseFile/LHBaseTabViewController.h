//
//  LHBaseTabViewController.h
//  BaseFile
//
//  Created by liuhao on 2019/11/25.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHBaseViewController.h"
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHBaseTabViewController : LHBaseViewController

///表对象
@property (nonatomic,strong) UITableView *tableview;

///表数据
@property (nonatomic,strong) NSMutableArray *dataSource;

///表页码
@property (nonatomic,assign,readonly) NSInteger pageNumber;

 
#pragma mark - 子类按需调用
 
/// 删除下拉刷新
-(void)removePullRefresh;

/// 主动下拉刷新
-(void)pullRefresh;

/// 结束刷新
/// @param isMore 是否有下一页
-(void)endRefreshingAndMore:(BOOL)isMore;
 
/// 显示加载更多  默认隐藏
-(void)showMoreRefresh;

/// 隐藏加载更多
-(void)hideMoreRefresh;

/// 刷新数据
-(void)refreshData;

#pragma mark - 子类按需继承重写

/// 设置 tableView样式
-(void)initTableViewStyle;

/// 设置 tableViewFrame
-(void)setTableViewFrame;

/// 注册 tableViewCell
-(void)regTableViewCell;

/// 下拉刷新调用
-(void)refresh;

/// 下拉加载调用
-(void)loadMore;
 
/// 配置 下拉刷新
/// @param mormalHeader MJRefreshNormalHeader
-(void)configHeaderRefreshStyleWith:(MJRefreshNormalHeader*)mormalHeader;

/// 配置 上啦加载
/// @param mormalFooter MJRefreshBackNormalFooter
-(void)configFooterRefreshStyleWith:(MJRefreshBackNormalFooter*)mormalFooter;
 
/// 加载数据
-(void)requsetData;

@end

NS_ASSUME_NONNULL_END
