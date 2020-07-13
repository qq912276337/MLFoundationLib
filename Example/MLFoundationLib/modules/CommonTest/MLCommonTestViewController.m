//
//  MLCommonTestViewController.m
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/7/13.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import "MLCommonTestViewController.h"

#import <MMKV/MMKV.h>
#import <Logan/Logan.h>
#import <sys/mman.h>
#import <sys/stat.h>

#import "MLMMAPUtl.h"

@interface MLCommonTestViewController ()

@property (nonatomic, copy) NSString *mapFullpath;

@property (nonatomic, assign) NSUInteger baseNum;

@end

@implementation MLCommonTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // important!!! you must replace this key and iv by your own.change key and iv at new version is more secure. we will provide a more secure way to protect your logs in the future.
//    NSData *keydata = [@"MLCommonTestViewController0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *ivdata = [@"MLCommonTestViewController0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
//    uint64_t file_max = 10 * 1024 * 1024;
//    // logan init，incoming 16-bit key，16-bit iv，largest written to the file size(byte)
//    loganInit(keydata, ivdata, file_max);
//
//    #if DEBUG
//    loganUseASL(YES);
//    #endif
    
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *str = @"original";
//    NSError *error;
//    NSString *filePath = [NSString stringWithFormat:@"%@/text.txt",path];
//    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    if (error) {
//        NSLog(@"%@",error);
//    }
//    ProcessFile(filePath.UTF8String);
//    NSString *result = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"---%@--",result);

    
//    logan(1, @"this is a test");
    
    
    
//    MMKV *mmkv = [MMKV defaultMMKV];
//
//    [mmkv setBool:YES forKey:@"bool"];
//    BOOL bValue = [mmkv getBoolForKey:@"bool"];
//
//    [mmkv setInt32:-1024 forKey:@"int32"];
//    int32_t iValue = [mmkv getInt32ForKey:@"int32"];
//
//    [mmkv setString:@"hello, mmkv" forKey:@"string"];
//    NSString *str = [mmkv getStringForKey:@"string"];
//
//    NSLog(@"---%@--",str);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - MMAP


- (IBAction)onAppendTextClick:(id)sender {
//    NSString *filePath = [self getMapfullPath];
//    void * dataPtr;
//    struct stat statInfo;
//
//    ReadFile([filePath UTF8String], &dataPtr, &statInfo);
//
//    NSData *data = [NSData dataWithBytes:dataPtr length:statInfo.st_size];
//
//    NSString *result =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"---%@--",result);


    
    NSString *filePath = [self getMapfullPath];
    NSTimeInterval time1 = [self getCurrentTimestamp];
    NSTimeInterval time2 = 0;
    for (int i = 0 + _baseNum; i  < 10000 + _baseNum; i++) {
        NSString *content = [NSString stringWithFormat:@"onAppendTextClick_%d \n",i];
        int result = ProcessFile([filePath UTF8String], [content UTF8String]);
        if(result != 0){
            NSLog(@"---%@--",@"ProcessFile");
        }
    }
    _baseNum += 10000;
    time2 = [self getCurrentTimestamp];
    NSLog(@"---ProcessFile:%f--",time2 - time1);
}

- (NSString *)getMapfullPath {
    if (_mapFullpath.length == 0) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [NSString stringWithFormat:@"%@/mapText.txt",path];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        }
        _mapFullpath = filePath;
    }
    return _mapFullpath;
}

// 获取当前时间戳
- (NSTimeInterval )getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    return time;
}

@end
