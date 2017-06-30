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

/** SQLite dao */
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
        NSString *SQL_InsertTaskData = [NSString stringWithFormat:SQL_INSERT_TASK,[task.roomID intValue],[task.taskInfo  intValue],[task.taskNumber  intValue],[task.taskStatus  intValue],task.taskCoordinate,task.taskBeside];
        BOOL success = [self.sqliteDao excuteSQL:SQL_InsertTaskData];
        if (success) {
            NSLog(@"insert success!");
        }
    }
      // category: 带参
    for (NSInteger i = 0; i < arrayOfCategories.count; i ++) {
        MZCategory *category = arrayOfCategories[i];
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
            NSLog(@"%@ insert success!",paramDict);
        }
    }
    
    // update
    NSString *SQL_UpdateTaskData = [NSString stringWithFormat:SQL_UPDATE_TASK, 10, 10, 10, 10,@"la",@"la", 10];
    [self.sqliteDao excuteSQL:SQL_UpdateTaskData];
    
    // delete
      // delete all
    //NSString *SQL_DeleteAllTaskData = [NSString stringWithFormat:SQL_DELETE_ALL,TABLE_TASK];
      // delete one record
    NSString *SQL_DeleteTaskData = [NSString stringWithFormat:SQL_DELETE,TABLE_TASK,@"TASK_ID",248];
    BOOL deleteSuccess = [self.sqliteDao excuteSQL:SQL_DeleteTaskData];
    if (deleteSuccess) {
        NSLog(@"delete success!");
    }
    
    // select
    NSString *SQL_SelectCategoryData = [NSString stringWithFormat:SQL_SELECT_ALL,TABLE_TASK];
    NSMutableArray *selectedTasks = [NSMutableArray array];
    // select *
    [self.sqliteDao excuteQuerySQL:SQL_SelectCategoryData resultBlock:^(FMResultSet *rsSet) {
        while ([rsSet next]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[rsSet objectForColumnName:@"TASK_ID"] forKey:@"TASK_ID"];
            [dict setValue:[rsSet objectForColumnName:@"ROOM_ID"] forKey:@"ROOM_ID"];
            [dict setValue:[rsSet objectForColumnName:@"TASK_INFO"] forKey:@"TASK_INFO"];
            [dict setValue:[rsSet objectForColumnName:@"TASK_NUMBER"] forKey:@"TASK_NUMBER"];
            [dict setValue:[rsSet objectForColumnName:@"TASK_STATUS"] forKey:@"TASK_STATUS"];
            [dict setValue:[rsSet objectForColumnName:@"TASK_COORDINATE"] forKey:@"TASK_COORDINATE"];
            [dict setValue:[rsSet objectForColumnName:@"TASK_BEDSIDE"] forKey:@"TASK_BEDSIDE"];
            [selectedTasks addObject:dict];
        }
    }];
    NSLog(@"selected all tasks:%@",selectedTasks);
    // select by ID
    NSString *SQL_SelectByID = [NSString stringWithFormat:SQL_SELECT_PARAMTER,TABLE_CATEGORY,@"CATEGORY_ID",6];
    [self.sqliteDao excuteQuerySQL:SQL_SelectByID resultBlock:^(FMResultSet *rsSet) {
        while ([rsSet next]) {
            // save as model data
            MZCategory *selectedCategory    = [MZCategory new];
            selectedCategory.categoryID     = [rsSet objectForColumnName:@"CATEGORY_ID"];
            selectedCategory.parentID       = [rsSet objectForColumnName:@"PARENT_ID"];
            selectedCategory.level          = [rsSet objectForColumnName:@"LEVEL"];
            selectedCategory.categoryName   = [rsSet objectForColumnName:@"CATEGORY_NAME"];
            selectedCategory.categoryImg    = [rsSet objectForColumnName:@"CATEGORY_IMG"];
            selectedCategory.categoryRank   = [rsSet objectForColumnName:@"CATEGORY_RANK"];
            selectedCategory.categoryType   = [rsSet objectForColumnName:@"CATEGORY_TYPE"];
            selectedCategory.categoryStatus = [rsSet objectForColumnName:@"CATEGORY_STATUS"];
            selectedCategory.categoryRemark = [rsSet objectForColumnName:@"CATEGORY_REMARK"];
            NSLog(@"select by categoryID:%d,parentID:%d,level:%d,categoryName:%@,categoryImg:%@,categoryRank:%d,categoryType:%d,categoryStatus:%d,categoryRemark:%@",[selectedCategory.categoryID intValue],[selectedCategory.parentID intValue],[selectedCategory.level intValue],selectedCategory.categoryName,selectedCategory.categoryImg,[selectedCategory.categoryRank intValue],[selectedCategory.categoryType intValue],[selectedCategory.categoryStatus intValue],selectedCategory.categoryRemark);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
