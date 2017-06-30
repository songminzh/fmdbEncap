//
//  MZDatabaseManager.m
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import "MZDatabaseManager.h"

@implementation MZDatabaseManager

+ (instancetype)sharedInstance {
    static MZDatabaseManager *databaseManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [MZDatabaseManager new];
    });
    return databaseManager;
}

- (void)createDatabaseWithName:(NSString *)name {
    NSString *dbPath = [MZDatabaseManager createPathWithDatabaseName:name];
    self.databaseQueue= [FMDatabaseQueue databaseQueueWithPath:dbPath];
}

/** 
 Create db and return full path 
 */
+ (NSString *)createPathWithDatabaseName:(NSString *)dbName {
    NSString *path = [NSString stringWithFormat:@"%@/%@/", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0], dbName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //创建数据库文件
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建数据库文件失败：%@,error:%@",path,error.userInfo);
        }
    }
    NSString *dbFullPath = [path stringByAppendingString:@"common.sqlite3"];
    NSLog(@"%@",dbFullPath);
    return dbFullPath;
}

@end
