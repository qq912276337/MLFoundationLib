//
//  MLPageTableController.m
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/10/14.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import "MLPageTableController.h"
#import "MLPageTableTextCell.h"
#import "MLPageTableImageCell.h"
#import "MLPageTableCellModel.h"

@interface MLPageTableController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MLPageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"MLPageTableTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MLPageTableTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MLPageTableImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MLPageTableImageCell"];

    [self setupData];
    [self.tableView reloadData];
}

- (void)setupData {
    MLPageTableCellModel *model0 = [MLPageTableCellModel new];
    model0.type = MLPageTableCellTypeText;
    model0.cellID = @"MLPageTableTextCell";
    model0.text = @"model0:MLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCellMLPageTableTextCell";
    
    MLPageTableCellModel *model1 = [MLPageTableCellModel new];
    model1.type = MLPageTableCellTypeImage;
    model1.cellID = @"MLPageTableImageCell";
    model1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xiangqing_1yuan.png" ofType:nil]];
    
    [self.items addObject:model0];
    [self.items addObject:model1];
    [self.items addObject:model0];
    [self.items addObject:model0];
    [self.items addObject:model0];
    [self.items addObject:model0];
    [self.items addObject:model0];
    [self.items addObject:model1];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLPageTableCellModel *model = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if(model.type == MLPageTableCellTypeText){
        MLPageTableTextCell *nowCell = (MLPageTableTextCell *)cell;
        nowCell.contentLabel.text = model.text;
    } else if(model.type == MLPageTableCellTypeImage) {
        MLPageTableImageCell *nowCell = (MLPageTableImageCell *)cell;
        nowCell.contentImageView.image = model.image;
        nowCell.contentImageView.contentMode = UIViewContentModeScaleToFill;
        nowCell.backgroundColor = [UIColor greenColor];
    }
    if(model.configureAction && [self respondsToSelector:NSSelectorFromString(model.configureAction)]){
        [self performSelector:NSSelectorFromString(model.configureAction) withObject:cell withObject:indexPath];
    }
    return cell;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
@end
