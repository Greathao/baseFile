//
//  LHBaseTabViewController.m
//  BaseFile
//
//  Created by liuhao on 2019/11/25.
//  Copyright © 2019 liuhao. All rights reserved.
//

#import "LHBaseTabViewController.h"

@interface LHBaseTabViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  MJRefreshNormalHeader * normalHeader;
@property (nonatomic,strong)  MJRefreshBackNormalFooter *normalFooter;
@property (nonatomic,assign,readwrite) NSInteger pageNumber;

@end

@implementation LHBaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableViewStyle];
    [self basicConfigTableView];
    [self setTableViewFrame];
    [self regTableViewCell];
    [self hideMoreRefresh];
}

#pragma mark - tableView 配置
-(void)initTableViewStyle
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

-(void)basicConfigTableView
{
    _tableview.backgroundColor = UIColorTableColor;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    if(@available(iOS 11.0, *)){
        _tableview.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

-(void)regTableViewCell
{
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
}

-(void)setTableViewFrame
{
    _tableview.frame = CGRectMake(0, NAV_HEIGHT, kScreenWidth, kScreenHeight-NAV_HEIGHT);
}

-(void)addHeaderRefresh
{
    MJRefreshNormalHeader * normalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    _tableview.tableHeaderView = normalHeader;
    [self configHeaderRefreshStyleWith:normalHeader];
    self.normalHeader = normalHeader;
}

-(void)addFooterRefresh
{
    MJRefreshBackNormalFooter *  normalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    _tableview.tableFooterView = normalFooter;
    [self configFooterRefreshStyleWith:normalFooter];
    self.normalFooter = normalFooter;
}
 
#pragma mark - 子类方法调用

/// 删除下拉刷新
-(void)removePullRefresh;
{
    _normalHeader = nil;
    self.tableview.mj_header = nil;
    
}

/// 主动下拉刷新
-(void)pullRefresh;
{
    if (_normalHeader) {
        [_normalHeader beginRefreshing];
    }
    
}

/// 结束刷新
/// @param isMore 是否有下一页
-(void)endRefreshingAndMore:(BOOL)isMore;
{
    if (_normalHeader) {
        [_normalHeader endRefreshing];
    }
    
    if (_normalFooter) {
        if (isMore) {
            [_normalFooter endRefreshing];
        }else{
            [_normalFooter  endRefreshingWithNoMoreData];
        }
    }
}

/// 显示加载更多  默认隐藏
-(void)showMoreRefresh;
{
    self.normalFooter.hidden = NO;
}

/// 隐藏加载更多
-(void)hideMoreRefresh;
{
    self.normalFooter.hidden = YES;
    
}

/// 刷新数据
-(void)refreshData;
{
    [self.tableview reloadData];
}

/// 初始化数据
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

#pragma mark - 子类方法重写

/// 下拉刷新调用
-(void)refresh;
{
    self.pageNumber = 1;
    
}

/// 下拉加载调用
-(void)loadMore;
{
    self.pageNumber ++;
}

/// 配置 下拉刷新
/// @param mormalHeader MJRefreshNormalHeader
-(void)configHeaderRefreshStyleWith:(MJRefreshNormalHeader*)mormalHeader;
{
    
}

/// 配置 上啦加载
/// @param mormalFooter MJRefreshBackNormalFooter
-(void)configFooterRefreshStyleWith:(MJRefreshBackNormalFooter*)mormalFooter;
{
    
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

@end
