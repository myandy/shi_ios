//
//  Writting.h
//  shishi
//
//  Created by tb on 2017/6/12.
//  Copyright © 2017年 andymao. All rights reserved.
//

//#import <FCModel/FCModel.h>
#import "BaseDBModel.h"

@interface Writting : BaseDBModel

+ (int64_t)indexValueForNewInstance;

@property (nonatomic, assign) int64_t id;
//用于排序
@property (nonatomic, assign) int64_t index;
@property (nonatomic, copy, nonnull) NSString *text;
@property (nonatomic, assign) int64_t formerId;
@property (nonatomic, copy) NSString * _Nonnull title;

@property (nonatomic) NSDate * _Nonnull create_dt;
@property (nonatomic) NSDate * _Nonnull update_dt;
@property (nonatomic, assign) int64_t bgImg;
@property (nonatomic, copy, nullable) NSString *author;

@end
