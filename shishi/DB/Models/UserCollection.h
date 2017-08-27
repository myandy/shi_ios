//
//  Collection.h
//  shishi
//
//  Created by tb on 2017/8/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "BaseDBModel.h"

@interface UserCollection : BaseDBModel
@property (nonatomic, assign) int64_t id;
@property (nonatomic, copy, nonnull) NSString *userId;
@property (nonatomic, assign) int64_t poetryId;
@property (nonatomic, copy, nonnull) NSString *poetryName;
@property (nonatomic) NSDate * _Nonnull create_dt;
@end
