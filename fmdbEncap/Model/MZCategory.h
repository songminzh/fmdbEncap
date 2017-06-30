//
//  MZCategory.h
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZCategory : NSObject

@property (nonatomic, strong) NSNumber *categoryID;

@property (nonatomic, strong) NSNumber *parentID;

@property (nonatomic, strong) NSNumber *level;

@property (nonatomic, strong) NSString *categoryName;

@property (nonatomic, strong) NSString *categoryImg;

@property (nonatomic, strong) NSNumber *categoryRank;

@property (nonatomic, strong) NSNumber *categoryType;

@property (nonatomic, strong) NSNumber *categoryStatus;

@property (nonatomic, strong) NSString *categoryRemark;

+ (NSMutableArray *)categoryMetedata;

@end
