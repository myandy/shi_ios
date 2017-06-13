//
//  Writting.m
//  shishi
//
//  Created by tb on 2017/6/12.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "Writting.h"

@implementation Writting

- (BOOL)save:(void (^)())modificiationsBlock
{
    return [super save:^{
        if (self.hasUnsavedChanges) self.create_dt = [NSDate date];
        if (! self.existsInDatabase) self.update_dt = [NSDate date];
        modificiationsBlock();
    }];
}


- (void)setValue:(nullable id)value forKey:(NSString *)key {
    if (![self customValue:value forKey:key]) {
        [super setValue:value forKey:key];
    }
}

- (BOOL)customValue:(nullable id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"create_dt"]) {
        NSNumber *numberValue = (NSNumber*)value;
        self.create_dt = [NSDate dateWithTimeIntervalSince1970:[numberValue floatValue]];
        return YES;
    }
    else if ([key isEqualToString:@"update_dt"]) {
        NSNumber *numberValue = (NSNumber*)value;
        self.update_dt = [NSDate dateWithTimeIntervalSince1970:[numberValue floatValue]];
        return YES;
    }
    return NO;
}
@end
