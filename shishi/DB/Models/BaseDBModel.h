//
//  BaseDBModel.h
//  shishi
//
//  Created by tb on 2017/6/13.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "FCModel.h"

@interface BaseDBModel : FCModel
- (BOOL)customValue:(nullable id)value forKey:(NSString *_Nonnull)key;
- (NSDate*_Nonnull)customDateWithValue:(nullable id)value;
@end
