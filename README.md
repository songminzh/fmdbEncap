# fmdbEncap
---------

## Motivation
---------
FMDB is a powerful tool for iOS processing data persistence，but still no easy to use. Therefore, it is necessary to encapsulate it and make it easier to use.These encapsulate vary from person to person, and should be optimized according to our code habits.So, I would like to provide a reference.


## What is fmdbEncap
---------
Use MZDatabaseManager to create SQLite database under the support of FMDB and create mothod in MZSqliteDao to do operations of insert,update,delete and select.


## How to use
---------
You should add `FMDB` frist,then add the folder of FMDBEncapsulation and Model in you project.

## Examples
---------

1.Create database

```
[[MZDatabaseManager sharedInstance] createDatabaseWithName:@"test"];
```

2.Create table

```
self.sqliteDao = [[MZSqliteDao alloc] init];
// create table
[self.sqliteDao createTable:TABLE_TASK withSQL:SQL_CREATE_TASK];
[self.sqliteDao createTable:TABLE_CATEGORY withSQL:SQL_CREATE_CATEGORY];
```

3.Insert 

```
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
```

4.Update

```
NSString *SQL_UpdateTaskData = [NSString stringWithFormat:SQL_UPDATE_TASK, 10, 10, 10, 10,@"la",@"la", 10];
[self.sqliteDao excuteSQL:SQL_UpdateTaskData];
```

5.Delete

```
//NSString *SQL_DeleteAllTaskData = [NSString stringWithFormat:SQL_DELETE_ALL,TABLE_TASK];
// delete one record
    NSString *SQL_DeleteTaskData = [NSString stringWithFormat:SQL_DELETE,TABLE_TASK,@"TASK_ID",248];
    BOOL deleteSuccess = [self.sqliteDao excuteSQL:SQL_DeleteTaskData];
    if (deleteSuccess) {
        NSLog(@"delete success!");
    }
```

6.Select

```
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
```
