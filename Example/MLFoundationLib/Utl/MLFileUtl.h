//
//  MLFileUtl.h
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/5/29.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLFileUtl : NSObject

/**
 *  创建文件
 *
 *  @author sml
 */
+ (BOOL )createFile:(NSString *)filePath content:(NSData *)content;
/**
 *  删除指定文件
 *
 *  @author sml
 */
+ (BOOL )deleteFile:(NSString *)filePath;
/**
 *  文件是否存在
 *
 *  @author sml
 */
+ (BOOL )existFile:(NSString *)filePath;

+ (NSArray<NSString *> *)filesAtDirectory:(NSString *)directoryPath isFullPath:(BOOL )isFullPath;

@end

NS_ASSUME_NONNULL_END
