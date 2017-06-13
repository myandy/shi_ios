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

@property (nonatomic, assign) int64_t id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) int formerId;
@property (nonatomic, copy) NSString *title;

@property (nonatomic) NSDate *create_dt;
@property (nonatomic) NSDate *update_dt;
@property (nonatomic, assign) int bgImg;
@property (nonatomic, copy) NSString *author;

@end
