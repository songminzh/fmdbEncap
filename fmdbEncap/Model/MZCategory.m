//
//  MZCategory.m
//  fmdbEncap
//
//  Created by Murphy Zheng on 17/6/30.
//  Copyright © 2017年 mulberry. All rights reserved.
//

#import "MZCategory.h"

@implementation MZCategory

+ (NSMutableArray *)categoryMetedata {
    NSMutableArray *arrayOfCategories = [NSMutableArray array];
    MZCategory *category = [MZCategory new];
    category.parentID = [NSNumber numberWithInteger:11];
    category.categoryID = [NSNumber numberWithInteger:19];
    category.level = [NSNumber numberWithInteger:1];
    category.categoryName = @"love";
    category.categoryImg = @"image";
    category.categoryRank = [NSNumber numberWithInteger:756];
    category.categoryType = [NSNumber numberWithInteger:35];
    category.categoryStatus = [NSNumber numberWithInteger:1];
    category.categoryRemark = @"nothing";
    
    for (NSInteger i = 0; i < 65; i ++) {
        [arrayOfCategories addObject:category];
    }
    return arrayOfCategories;
}

@end
