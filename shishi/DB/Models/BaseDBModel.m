//
//  BaseDBModel.m
//  shishi
//
//  Created by tb on 2017/6/13.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "BaseDBModel.h"




@implementation BaseDBModel

- (BOOL)customValue:(nullable id)value forKey:(NSString *)key {
    return NO;
}

- (NSDate*)customDateWithValue:(nullable id)value {
    NSNumber *numberValue = (NSNumber*)value;
    return [NSDate dateWithTimeIntervalSince1970:[numberValue floatValue]];
}



@end
