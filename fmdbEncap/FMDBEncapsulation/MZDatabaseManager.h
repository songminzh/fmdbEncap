//
//  MZDatabaseManager.h
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface MZDatabaseManager : NSObject

/** database quene */
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

/**
 single case
 
 @return CLDatabaseManager
 */
+ (instancetype)sharedInstance;


/**
 Create database

 @param name database name
 */
- (void)createDatabaseWithName:(NSString *)name;

@end
