//
//  MLPageTableCellModel.h
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/10/14.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,MLPageTableCellType) {
    MLPageTableCellTypeText,
    MLPageTableCellTypeImage,
};

NS_ASSUME_NONNULL_BEGIN

@interface MLPageTableCellModel : NSObject

@property (nonatomic, assign) MLPageTableCellType type;

@property (nonatomic, copy) NSString *cellID;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
