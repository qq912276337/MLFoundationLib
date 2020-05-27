//
//  MLTitleValueModel.h
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/5/27.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MLTitleValueClickBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MLTitleValueModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) MLTitleValueClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
