//
//  MZDatabase.h
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#ifndef MZDatabase_h
#define MZDatabase_h

/** Table Name */

#define     TABLE_TASK                   @"FMDB_TASK"
#define     TABLE_CATEGORY               @"FMDB_CATEGORY"

/** Create tables */

#define     SQL_CREATE_TASK              @"CREATE TABLE IF NOT EXISTS FMDB_TASK(\
                                           TASK_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL,\
                                           ROOM_ID int(11) NOT NULL DEFAULT 0,\
                                           TASK_INFO int(11),\
                                           TASK_NUMBER int(4) NOT NULL,\
                                           TASK_STATUS int(4) NOT NULL,\
                                           TASK_COORDINATE varchar(20),\
                                           TASK_BEDSIDE varchar(20)\
                                           );"

#define     SQL_CREATE_CATEGORY          @"CREATE TABLE IF NOT EXISTS FMDB_CATEGORY(\
                                           CATEGORY_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL,\
                                           PARENT_ID int(11) NOT NULL,\
                                           LEVEL int(11),\
                                           CATEGORY_NAME nvarchar(45) NOT NULL,\
                                           CATEGORY_IMG varchar(100),\
                                           CATEGORY_RANK int(11) NOT NULL,\
                                           CATEGORY_TYPE int(4) NOT NULL,\
                                           CATEGORY_STATUS int(11) NOT NULL,\
                                           CATEGORY_REMARK nvarchar(100)\
                                           );"

/** Insert */

#define     SQL_INSERT_TASK              @"INSERT INTO FMDB_TASK\
                                           ( ROOM_ID, TASK_INFO, TASK_NUMBER,\
                                           TASK_STATUS, TASK_COORDINATE, TASK_BEDSIDE)\
                                           VALUES ( '%ld', '%ld', '%ld', '%ld', '%@', '%@');"

#define     SQL_INSERT_CATEGORY          @"INSERT INTO FMDB_CATEGORY\
                                           ( PARENT_ID, LEVEL, CATEGORY_NAME, CATEGORY_IMG,\
                                           CATEGORY_RANK, CATEGORY_TYPE, CATEGORY_STATUS, CATEGORY_REMARK)\
                                           VALUES ( '%ld', '%ld', '%@', '%ld', '%ld', '%ld', '%ld', '%@');"

#define     SQL_INSERT_TASK_PARAMTER     @"INSERT INTO FMDB_TASK\
                                           ( ROOM_ID, TASK_INFO, TASK_NUMBER,\
                                           TASK_STATUS, TASK_COORDINATE, TASK_BEDSIDE)\
                                           VALUES (\
                                           :roomID, :taskInfo, :taskNumber, :taskStatus, :taskCoordinate, :taskBeside);"

#define     SQL_INSERT_CATEGORY_PARAMTER @"INSERT INTO FMDB_CATEGORY\
                                           ( PARENT_ID, LEVEL, CATEGORY_NAME, CATEGORY_IMG,\
                                           CATEGORY_RANK, CATEGORY_TYPE, CATEGORY_STATUS, CATEGORY_REMARK)\
                                           VALUES (\
                                           :prantID, :level, :categoryName, :categoryImage, :categoryRank, :categoryType, :categoryStatus, :categoryRemark);"

/** Update */

#define     SQL_UPDATE_TASK              @"UPDATE FMDB_TASK\
                                           SEL ROOM_ID = '%ld', TASK_INFO = '%ld', TASK_NUMBER = '%ld',\
                                           TASK_STATUS = '%ld', TASK_COORDINATE = '%@', TASK_BEDSIDE = '%@'\
                                           WHERE TASK_ID = '%ld';"

#define     SQL_UPDATE_CATEGORY          @"UPDATE FMDB_CATEGORY\
                                           SEL PARENT_ID = '%ld', LEVEL = '%ld', CATEGORY_NAME = '%@',\
                                           CATEGORY_IMG = '%ld',CATEGORY_RANK = '%ld', CATEGORY_TYPE = '%ld',\
                                           CATEGORY_STATUS = '%ld',CATEGORY_REMARK = '%@'\
                                           WHERE CATEGORY_ID = '%ld';"


/** Delete */

#define     SQL_DELETE                   @"DELETE FROM %@ WHERE '%@'='%ld';"

/** Select */

#define     SQL_SELECT_ALL               @"SELECT * FROM %@;"

#define     SQL_SELECT_PARAMTER          @"SELECT * FROM %@ WHERE %@ = '%ld';"

#endif /* MZDatabase_h */
