//
//  MZTask.m
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import "MZTask.h"

@implementation MZTask

+ (NSMutableArray *)taskMetedata {
    NSMutableArray *arrayOfTasks = [NSMutableArray array];
    MZTask *task_01 = [MZTask new];
    task_01.taskID = [NSNumber numberWithInteger:1];
    task_01.roomID = [NSNumber numberWithInteger:23];
    task_01.taskInfo = @"taskInfo";
    task_01.taskNumber = [NSNumber numberWithInteger:19];
    task_01.taskStatus = [NSNumber numberWithInteger:0];
    task_01.taskCoordinate = @"(8,9)";
    task_01.taskBeside = @"(1,3)";
    
    for (NSInteger i = 0; i < 12; i ++) {
        [arrayOfTasks addObject:task_01];
    }
    return arrayOfTasks;
}

@end
