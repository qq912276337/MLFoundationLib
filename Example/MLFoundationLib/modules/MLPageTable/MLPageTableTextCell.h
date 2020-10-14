//
//  MLPageTableTextCell.h
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/10/14.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMLPageTableTextCellID @"MLPageTableTextCell"

NS_ASSUME_NONNULL_BEGIN

@interface MLPageTableTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
