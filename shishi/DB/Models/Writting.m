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

@end
