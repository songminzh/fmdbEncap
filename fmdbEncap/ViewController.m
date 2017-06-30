//
//  ViewController.m
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import "ViewController.h"
#import "MZDatabase.h"
#import "MZSqliteDao.h"
#import "MZDatabaseManager.h"
#import "MZTask.h"
#import "MZCategory.h"

@interface ViewController ()

/** sqlite dao */
@property (nonatomic, strong) MZSqliteDao *sqliteDao;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDatabase];
}

- (void)createDatabase {
    // create database
    [[MZDatabaseManager sharedInstance] createDatabaseWithName:@"test"];
    
    self.sqliteDao = [[MZSqliteDao alloc] init];
    // create table
    [self.sqliteDao createTable:TABLE_TASK withSQL:SQL_CREATE_TASK];
    [self.sqliteDao createTable:TABLE_CATEGORY withSQL:SQL_CREATE_CATEGORY];
    
    // insert
    NSArray *arrayOfTasks = [MZTask taskMetedata];
    NSArray *arrayOfCategories = [MZCategory categoryMetedata];
    
      // task: SQL 语句拼接
    for (MZTask *task in arrayOfTasks) {
        NSString *SQL_InsertTaskData = [NSString stringWithFormat:SQL_INSERT_TASK,[task.roomID integerValue],[task.taskInfo integerValue],[task.taskNumber integerValue],[task.taskStatus integerValue],task.taskCoordinate,task.taskBeside];
        BOOL success = [self.sqliteDao excuteSQL:SQL_InsertTaskData];
        if (success) {
            
        }
    }
      // category: 带参
    for (NSInteger i = 0; i < arrayOfCategories.count; i ++) {
        MZCategory *category = arrayOfCategories[i];
        /*
         :prantID, :level, :categoryName, :categoryImage, :categoryRank, :categoryType, :categoryStatus, :categoryRemark
         */
        NSDictionary *paramDict = @{@"prantID":category.parentID,
                                    @"level":category.level,
                                    @"categoryName":category.categoryName,
                                    @"categoryImage":category.categoryImg,
                                    @"categoryRank":category.categoryRank,
                                    @"categoryType":category.categoryType,
                                    @"categoryStatus":category.categoryStatus,
                                    @"categoryRemark":category.categoryRemark
                                    };
        BOOL success = [self.sqliteDao excuteSQL:SQL_INSERT_CATEGORY_PARAMTER withDicParameter:paramDict];
        if (success) {
            
        }
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
