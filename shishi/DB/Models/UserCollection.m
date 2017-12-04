//
//  Collection.m
//  shishi
//
//  Created by tb on 2017/8/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "UserCollection.h"

@implementation UserCollection

- (BOOL)save:(void (^)())modificiationsBlock
{
    return [super save:^{
        if (!self.existsInDatabase) {
            self.create_dt = [NSDate date];
        }
        if (modificiationsBlock != nil) {
            modificiationsBlock();
        }
        
    }];
}


- (void)setValue:(nullable id)value forKey:(NSString *)key {
    if (![self customValue:value forKey:key]) {
        [super setValue:value forKey:key];
    }
}

- (BOOL)customValue:(nullable id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"create_dt"]) {
        self.create_dt = [self customDateWithValue:value];
        return YES;
    }
    return NO;
}

@end
