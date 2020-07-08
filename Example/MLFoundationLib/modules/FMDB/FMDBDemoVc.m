//
//  FMDBDemoVc.m
//  MLFoundationLib_Example
//
//  Created by sml2 on 2020/5/27.
//  Copyright © 2020 qq912276337. All rights reserved.
//

#import "FMDBDemoVc.h"
#import <FMDB/FMDB.h>
#import "MLFileUtl.h"

typedef void(^FMDBDemoVcClickBlock)(void);

@interface FMDBDemoVc ()

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *items;

@property (nonatomic, copy) FMDBDemoVcClickBlock clickBlock;

@end

@implementation FMDBDemoVc

- (void)dealloc{
    NSLog(@"---%@--",@"dealloc");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataBase];
    
    self.clickBlock = ^{
        [self createDataBase];
    };
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.clickBlock){
        self.clickBlock();
    }
}

- (void)createDataBase {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"test.sqlite"];
    BOOL isDelete = [MLFileUtl deleteFile:path];
    NSLog(@"---%ld--",isDelete);
    
    NSLog(@"path = %@",path);
    // 1..创建数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    // 2.打开数据库
    if ([db open]) {
        // do something
        NSLog(@"Open database Success");
        
        NSDictionary *dict = @{
            @"x":@"sml",
            @"y":@"sml2"
        };
        
        NSArray *arr = @[
            @{
                @"table":@"bulktest1",
                @"key":@"x",
                @"value":@"1y",
            },
            @{
                @"table":@"bulktest2",
                @"key":@"y",
                @"value":@"2y",
            },
        ];
                
        NSMutableString *sql = [NSMutableString string];
        [sql appendString:@"create table bulktest1 (id integer primary key autoincrement, x text,x1 text);"];
        [sql appendString:@"create table bulktest2 (id integer primary key autoincrement, y text,y1 text);"];
        for (NSDictionary *dict in arr) {
            [sql appendFormat:@"insert into %@ (%@) values (%@);",dict[@"table"],dict[@"key"],[self valueFormatterString:dict[@"value"]]];
        }
//        [sql appendString:[NSString stringWithFormat:@"insert into bulktest1 (x) values (%@);",@"'1y'"]];
//        [sql appendString:[NSString stringWithFormat:@"insert into bulktest2 (y) values (%@);",@"'2y'"]];

//        NSString *sql = @"create table bulktest1 (id integer primary key autoincrement, x text);"
//                         "create table bulktest2 (id integer primary key autoincrement, y text);"
//                         "insert into bulktest1 (x) values ('XXX');"
//                         "insert into bulktest2 (y) values ('YYY');"

        BOOL success = [db executeStatements:sql];
        NSLog(@"---%ld--",success);
        [db close];
    } else {
        NSLog(@"fail to open database");
    }
}

- (NSArray *)getTestItems {
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i  < 5000; i++) {
        NSDictionary *dict = @{
            @"":@"",
            @"":@"",
        };
    }
    return items;
    
}

- (NSString *)valueFormatterString:(id )value {
    if([value isKindOfClass:[NSString class]]){
        return @"'%@'";
    } else {
        return @"%@";
    }
}

- (NSMutableArray<NSDictionary *> *)items{
    if(!_items){
        _items = @[].mutableCopy;
        for (int i = 0; i  < 10000; i++) {
            NSDictionary *dict = @{
                @"id":@"",
            };
        }
        
    }
    return _items;
}

@end
