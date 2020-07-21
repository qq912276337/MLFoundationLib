//
//  MLMMAPUtl.m
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/7/13.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import "MLMMAPUtl.h"

#include<sys/stat.h>
#include<sys/mman.h>

/**
 * 读取文件
 * @param inPathName 文件路径
 * @param outDataPtr 映射文件的起始位置
 * @return stat 文件状态
 * @by sml
 */
int ReadFile(char *inPathName,void **outDataPtr,struct stat *stat){
    size_t originLength;  // 原数据字节数
    int fd;               // 文件
    int outError;         // 错误信息
    // 打开文件
    fd = open(inPathName, O_RDWR | O_CREAT,0);
    if(fd < 0){
        outError = errno;
        return 1;
    }
    // 获取文件状态
    int fsta = fstat(fd, stat);
    if(fsta != 0){
        outError = errno;
        return 1;
    }
    // 计算映射大小
    originLength = (*stat).st_size;
    size_t mapsize = originLength;
    // 映射文件
    int result = MapFile(fd, outDataPtr, mapsize);
    if(result == 0){
        //
    } else{
        // 映射失败
        outError = errno;
        NSLog(@"ReadFile映射失败M:%d",outError);
        return 1;
    }
    return 0;
}

/**
 * 写入文件
 * @param inPathName 文件路径
 * @param string 内容
 * @return 0代表映射文件成功 其他代表失败
 * @by sml
 */
int ProcessFile(char *inPathName,char *string){
    void *dataPtr;       // 文件写入起始地址
//    void *start;         // 文件起始地址
    size_t originLength;  // 原数据字节数
    size_t dataLength;    // 数据字节数
    struct stat statInfo; // 文件状态
    int fd;               // 文件
    int outError;         // 错误信息
    mode_t f_attrib;      // 声明mode_t

    f_attrib = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
    // 打开文件
    fd = open( inPathName, O_RDWR | O_CREAT, f_attrib );
    if(fd < 0){
        outError = errno;
        return 1;
    }
    // 获取文件状态
    int fsta = fstat(fd, &statInfo);
    if(fsta != 0){
        outError = errno;
        return 1;
    }
    // 计算映射大小
    dataLength = strlen(string);
    originLength = statInfo.st_size;
    size_t mapSize = dataLength + originLength;
    // 文件映射到内存
    int result = MapFile(fd,&dataPtr,mapSize);
    if(result == 0){
//        start = dataPtr;
        // 移到末尾
        dataPtr = dataPtr + statInfo.st_size;
        memcpy(dataPtr, string, dataLength);
        close( fd );
    } else {
        NSLog(@"ProcessFile映射失败:%d",result);
        return 1;
    }
    return 0;
}

/**
 * 映射文件
 * @param fd 代表文件
 * @param outDataPtr 映射文件的起始位置
 * @param mapSize 映射的size
 * @return 0代表映射文件成功 其他代表失败
 * @by sml
 */
int MapFile(int fd,void **outDataPtr,size_t mapSize){
    int outError;         // 错误信息
    outError = 0;
    *outDataPtr = NULL;
    // 映射
    *outDataPtr = mmap(NULL, mapSize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
    if(*outDataPtr == MAP_FAILED){
        outError = errno;
    } else {
        // 调整文件大小并刷新
        ftruncate(fd, mapSize);
        fsync(fd);
    }
    return outError;
}


@implementation MLMMAPUtl



@end
