//
//  MLMmapManager.m
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/7/20.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import "MLMmapManager.h"
#include<sys/mman.h>
#include<sys/stat.h>

#define MMAP_FILE_DEAFULT_SIZE (32 * 1024)

/**
 * 映射文件
 * @param fd 代表文件
 * @param outDataPtr 映射文件的起始位置
 * @param mapSize 映射的size
 * @return 0代表映射文件成功 其他代表失败
 * @by sml
 */
int DL_MapFile(int fd,void **outDataPtr,size_t mapSize){
    int outError;         // 错误信息
    outError = 0;
    *outDataPtr = NULL;
    // 调整文件大小并刷新
    ftruncate(fd, mapSize);
    fsync(fd);
    // 映射
    *outDataPtr = mmap(NULL, mapSize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
    if(*outDataPtr == MAP_FAILED){
        outError = errno;
    }
    return outError;
}

/**
 * 映射关系解除
 * @param addr 调用mmap()时返回的地址
 * @param len len是映射区的大小
 * @return 成功执行时，munmap()返回0。失败时，munmap返回-1，error返回标志和mmap一致
 * @by sml
 */
int DL_Munmap( void * addr, size_t len ){
    return munmap(addr,len);
}

@interface MLMmapManager (){
    // 文件起始地址
    void *_ptr;
    // 文件
    int _fd;
    // 文件内容大小
    size_t _currentSize;
}

@end
@implementation MLMmapManager

#pragma mark - Public

+ (instancetype)sharedManager {
    static MLMmapManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Interval

- (BOOL )writeToFile:(NSString *)filePath content:(NSString *)content {
    const char*inPathName = filePath.UTF8String;
    const char*string = content.UTF8String;
    void *ptr;            // 文件内容句柄地址
    size_t dataLength;    // 数据字节数
    struct stat statInfo; // 文件状态
    int fd;               // 文件
    int outError;         // 错误信息
    if(!_fd){
        mode_t f_attrib;      // 声明mode_t
        // 文件权限
        f_attrib = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
        // 打开文件
        fd = open( inPathName, O_RDWR | O_CREAT, f_attrib );
        if(fd < 0){
            outError = errno;
            return 1;
        }
    } else {
        fd = _fd;
    }
    // 获取文件状态
    int fsta = fstat(fd, &statInfo);
    if(fsta != 0){
        outError = errno;
        return 1;
    }
    // 计算映射大小
    dataLength = strlen(string);
    if(!_ptr){
        _currentSize = statInfo.st_size;
        size_t mapSize = ((_currentSize + dataLength) / MMAP_FILE_DEAFULT_SIZE + 1) * MMAP_FILE_DEAFULT_SIZE;
        // 文件映射到内存
        int result = DL_MapFile(fd,&ptr,mapSize);
        if(result == 0){
            _ptr = ptr;
            _currentSize += dataLength;
            // 移到末尾
            ptr = ptr + statInfo.st_size;
            memcpy(ptr, string, dataLength);
        } else {
            NSLog(@"ProcessFile映射失败:%d",result);
            return 1;
        }
    } else {
        // 扩容处理
        if(_currentSize + dataLength > statInfo.st_size){
            // 解除
            DL_Munmap(_ptr, _currentSize);
            // 扩容并映射
            size_t mapSize = statInfo.st_size;
            while (mapSize < _currentSize + dataLength) {
                NSLog(@"执行扩容mapSize:%ld _currentSize:%ld dataLength:%ld",mapSize,_currentSize,dataLength);
                mapSize = mapSize + MMAP_FILE_DEAFULT_SIZE;
            }
            NSLog(@"扩容完成:mapSize:%ld",mapSize);

            int result = DL_MapFile(fd,&ptr,mapSize);
            if(result == 0){
                _ptr = ptr;
            } else {
                NSLog(@"ProcessFile扩容映射失败:%d",result);
                return 1;
            }
        }
        void *ptr2 = _ptr + _currentSize;
        memcpy(ptr2, string, dataLength);
        _currentSize += dataLength;
    }
    _fd = fd;
    return 0;
}

@end
