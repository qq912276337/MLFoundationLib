//
//  MLMMAPUtl.h
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/7/13.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int ProcessFile(char *inPathName,char *string);

extern int MapFile(int fd,void **outDataPtr,size_t mapSize);

extern int ReadFile(char *inPathName,void **outDataPtr,struct stat * stat);

NS_ASSUME_NONNULL_BEGIN

@interface MLMMAPUtl : NSObject

@end

NS_ASSUME_NONNULL_END
