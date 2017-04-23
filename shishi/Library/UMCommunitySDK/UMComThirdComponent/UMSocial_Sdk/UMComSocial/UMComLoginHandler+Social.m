//
//  UMComLoginHandler+Social.m
//  UMCommunity
//
//  Created by wyq.Cloudayc on 8/4/16.
//  Copyright © 2016 Umeng. All rights reserved.
//

#import "UMComLoginHandler+Social.h"
#import "UMSocial.h"
#import <UMComFoundation/UMComKit+Runtime.h>
@implementation UMComLoginHandler (Social)

+ (void)load
{
    [UMComKit swizzleInstanceMethod:[self class] originalSelector:@selector(setAppKey:) swizzledSelector:@selector(swizzle_setAppKey:)];
    [UMComKit swizzleInstanceMethod:[self class] originalSelector:@selector(handleOpenURL:) swizzledSelector:@selector(swizzle_handleOpenURL:)];
}

- (void)swizzle_setAppKey:(NSString *)appKey
{
    [UMSocialData setAppKey:appKey];
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionBottom];
}

- (BOOL)swizzle_handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

@end
