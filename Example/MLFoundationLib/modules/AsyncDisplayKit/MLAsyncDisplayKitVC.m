//
//  DLTempViewController.m
//  PocketSLH
//
//  Created by sml2 on 2020/6/11.
//

#import "MLAsyncDisplayKitVC.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "DLTempCellNode.h"
#import <MJRefresh/MJRefresh.h>

@interface MLAsyncDisplayKitVC ()<ASTableDelegate,ASTableDataSource>

@property (strong, nonatomic) ASTableNode *tableNode;

@property (nonatomic, strong) NSMutableArray *imageCategories;


@end

@implementation MLAsyncDisplayKitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageCategories = @[].mutableCopy;
    
//    for (int i = 0; i  < 10; i++) {
//        [_imageCategories addObject:[NSString stringWithFormat:@"%d",i]];
//    }

    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    
    [self.view addSubnode:self.tableNode];
    [self wireDelegation];
    
    [self applyStyle];
    
    __weak typeof(self) weakSelf = self;
    // setup pull-to-refresh
    self.tableNode.view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    
    // setup infinite scrolling
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerRefresh];
    }];
    self.tableNode.view.mj_footer = footer;
    
    
    [self headerRefresh];
    // Do any additional setup after loading the view.
}

- (void)headerRefresh {
    [self.tableNode.view.mj_header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_imageCategories removeAllObjects];
        for (int i = 0; i  < 20; i++) {
            [_imageCategories addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [self.tableNode.view.mj_header endRefreshing];
        [self.tableNode reloadData];
    });
}

- (void)footerRefresh {
    [self.tableNode.view.mj_footer beginRefreshing];
    NSInteger count = _imageCategories.count;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i  < 20; i++) {
            [_imageCategories addObject:[NSString stringWithFormat:@"%ld",i + count]];
        }
        [self.tableNode.view.mj_footer endRefreshing];
        [self.tableNode reloadData];
    });
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableNode.frame = self.view.bounds;
}

- (void)wireDelegation {
    self.tableNode.dataSource = self;
    self.tableNode.delegate = self;
}

- (void)applyStyle {
    self.view.backgroundColor = [UIColor blackColor];
    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
}
    
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    NSLog(@"---self.imageCategories.count:%ld--",self.imageCategories.count);

  return self.imageCategories.count;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLTempCellNode *cellNode = [DLTempCellNode new];
    cellNode.backgroundColor = indexPath.row % 2 == 0 ? [UIColor grayColor] : [UIColor blueColor];;
    cellNode.nameNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"DLTempCellNode:%ld",indexPath.row]];
    return cellNode;
}

-(ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize min = CGSizeMake(width,44);
    CGSize max = CGSizeMake(width, INFINITY);
    
    return ASSizeRangeMake(min, max);
}

@end
