//
//  MZSqliteDao.m
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import "MZSqliteDao.h"

@implementation MZSqliteDao
- (id)init {
    if (self = [super init]) {
        self.dbQueue = [MZDatabaseManager sharedInstance].databaseQueue;
    }
    return self;
}

- (BOOL)createTable:(NSString *)tableName withSQL:(NSString *)sqlString {
    __block BOOL success = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if(![db tableExists:tableName]) {
            success = [db executeUpdate:sqlString withArgumentsInArray:nil];
        }
        if (success) {
            NSLog(@"Table %@ create success!",tableName);
        }else {
            NSLog(@"Table %@ create error:%@",tableName,[db lastErrorMessage]);
        }
    }];
    return success;
}

- (BOOL)excuteSQL:(NSString *)sqlString withArrParameter:(NSArray *)arrParameter {
    __block BOOL success = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sqlString withArgumentsInArray:arrParameter];
        }];
    }
    return success;
}

- (BOOL)excuteSQL:(NSString *)sqlString withDicParameter:(NSDictionary *)dicParameter {
    __block BOOL success = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sqlString withParameterDictionary:dicParameter];
        }];
    }
    return success;
}

- (BOOL)excuteSQL:(NSString *)sqlString,... {
    __block BOOL success = NO;
    if (self.dbQueue) {
        va_list args;
        va_list *p_args;
        p_args = &args;
        va_start(args, sqlString);
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sqlString withVAList:*p_args];
        }];
        va_end(args);
    }
    return success;
}

- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void (^)(FMResultSet * rsSet))resultBlock {
    if (self.dbQueue) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet * retSet = [db executeQuery:sqlStr];
            if (resultBlock) {
                resultBlock(retSet);
            }
        }];
    }
}

@end
