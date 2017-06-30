//
//  MZTask.h
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZTask : NSObject

@property (nonatomic, strong) NSNumber *taskID;

@property (nonatomic, strong) NSNumber *roomID;

@property (nonatomic, strong) NSString *taskInfo;

@property (nonatomic, strong) NSNumber *taskNumber;

@property (nonatomic, strong) NSNumber *taskStatus;

@property (nonatomic, strong) NSString *taskCoordinate;

@property (nonatomic, strong) NSString *taskBeside;

+ (NSMutableArray *)taskMetedata;

@end
