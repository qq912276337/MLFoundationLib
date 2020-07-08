//
//  MLViewController.m
//  MLFoundationLib
//
//  Created by qq912276337 on 05/23/2020.
//  Copyright (c) 2020 qq912276337. All rights reserved.
//

#import "MLViewController.h"
#import <Masonry/Masonry.h>
#import "MLTitleValueModel.h"

#import "FMDBDemoVc.h"
#import "MLAsyncDisplayKitVC.h"
#import "MLLockViewController.h"

static NSString *kMLVcCellKey = @"kMLVcCellKey";

@interface MLViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MLViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
    
    [self setupData];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;
    
    [self.items addObject:[self modelWithTitle:NSStringFromClass([FMDBDemoVc class]) clickBlock:^{
        [weakSelf.navigationController pushViewController:[FMDBDemoVc new] animated:YES];
    }]];
    
    [self.items addObject:[self modelWithTitle:NSStringFromClass([MLAsyncDisplayKitVC class]) clickBlock:^{
        [weakSelf.navigationController pushViewController:[MLAsyncDisplayKitVC new] animated:YES];
    }]];
    
    [self.items addObject:[self modelWithTitle:NSStringFromClass([MLLockViewController class]) clickBlock:^{
        [weakSelf.navigationController pushViewController:[MLLockViewController new] animated:YES];
    }]];
    
    [self.tableView reloadData];
}

- (MLTitleValueModel *)modelWithTitle:(NSString *)title clickBlock:(MLTitleValueClickBlock )clickBlock {
    MLTitleValueModel *model = [MLTitleValueModel new];
    model.title = title;
    model.clickBlock = clickBlock;
    return model;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMLVcCellKey forIndexPath:indexPath];
    MLTitleValueModel *model = self.items[indexPath.row];
    cell.textLabel.text = model.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLTitleValueModel *model = self.items[indexPath.row];
    if(model.clickBlock){
        model.clickBlock();
    }
}


#pragma mark - Getter and Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 60;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMLVcCellKey];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if([_tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
            _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
    }
    return _tableView;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

@end
