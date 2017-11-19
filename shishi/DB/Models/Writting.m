//
//  Writting.m
//  shishi
//
//  Created by tb on 2017/6/12.
//  Copyright © 2017年 andymao. All rights reserved.
//

#import "Writting.h"


@implementation Writting


+ (int64_t)indexValueForNewInstance
{
    NSArray *allValues = [Writting allInstances];
    
    NSArray *sortValues = [allValues sortedArrayWithOptions:0
                          usingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Writting* writting1 = obj1;
        Writting* writting2 = obj2;
        return writting1.orderIndex > writting2.orderIndex;
    }];
    
    int64_t newIndex = allValues.count == 0 ? 0 : (((Writting*)[sortValues lastObject]).orderIndex + 1);
    return newIndex;
}

- (BOOL)save:(void (^)())modificiationsBlock
{
//    if (!self.existsInDatabase) {
//        self.id = (int64_t)[[self class] primaryKeyValueForNewInstance];
//    }
    
    if (!self.existsInDatabase) {
        self.orderIndex = [self.class indexValueForNewInstance];
    }
    
    return [super save:^{
        if (self.hasUnsavedChanges) self.create_dt = [NSDate date];
        if (!self.existsInDatabase) {
            self.update_dt = [NSDate date];
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
    else if ([key isEqualToString:@"update_dt"]) {
        self.update_dt = [self customDateWithValue:value];
        return YES;
    }
    return NO;
}



@end
