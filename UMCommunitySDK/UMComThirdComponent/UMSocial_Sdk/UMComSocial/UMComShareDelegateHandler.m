//
//  UMComShareDelegatehandler.m
//  UMCommunity
//
//  Created by umeng on 16/3/3.
//  Copyright © 2016年 Umeng. All rights reserved.
//

#import "UMComShareDelegateHandler.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import <UMComDataStorage/UMComFeed.h>
#import <UMCommunitySDK/UMCommunitySDK.h>
#import <UMComDataStorage/UMComImageUrl.h>
#import <UMCommunitySDK/UMComDataRequestManager.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>

#define MaxShareLength 137
#define MaxLinkLength 10

@interface UMComShareDelegateHandler ()

@property (nonatomic, strong) UMComFeed *feed;

@end

@implementation UMComShareDelegateHandler

static UMComShareDelegateHandler *_instance = nil;
+ (UMComShareDelegateHandler *)shareInstance {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

- (void)setAppKey:(NSString *)appKey
{
    [UMSocialData setAppKey:appKey];
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionBottom];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

- (void)didSelectPlatformAtIndex:(NSInteger)platformIndex
                            feed:(UMComFeed *)feed
                  viewController:(UIViewController *)viewControlller
{
    NSArray *platforms = [self sharePlatform];
    
    if (platformIndex < 0 || platformIndex >= platforms.count) {
        return;
    }
    NSString *platformName = platforms[platformIndex];
    UMComFeed *shareFeed = nil;
    if (feed.origin_feed) {
        shareFeed = feed.origin_feed;
    } else{
        shareFeed = feed;
    }
    self.feed = feed;
    NSArray *imageModels = [shareFeed image_urls];
    UMComImageUrl *imageModel = nil;
    if (imageModels.count > 0) {
        imageModel = [[shareFeed image_urls] firstObject];
    }
    NSString *imageUrl = imageModel.small_url_string;//[[shareFeed.images firstObject] valueForKey:@"360"];
    
    //取转发的feed才有链接
    NSString *urlString = self.feed.share_link;
    urlString = [NSString stringWithFormat:@"%@?ak=%@&platform=%@",urlString,[UMCommunitySDK appKey],platformName];
    [UMSocialData defaultData].extConfig.qqData.url = urlString;
    [UMSocialData defaultData].extConfig.qzoneData.url = urlString;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlString;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlString;
//    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;

    
    NSString *shareText = [NSString stringWithFormat:@"%@ %@",shareFeed.text,urlString];
    if (shareFeed.text.length > MaxShareLength+2 - MaxLinkLength) {
        NSString *feedString = [shareFeed.text substringToIndex:MaxShareLength - MaxLinkLength];
        shareText = [NSString stringWithFormat:@"%@…… %@",feedString,urlString];
    }
    [UMSocialData defaultData].extConfig.sinaData.shareText = shareText;
    
    NSString *title = shareFeed.title;
    if (title.length == 0) {
        title = shareText;
    }
    [UMSocialData defaultData].title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    [UMSocialData defaultData].extConfig.qzoneData.title = title;
    [UMSocialData defaultData].extConfig.qqData.title = title;
    UIImage *shareImage = nil;
    if (imageUrl) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    } else{
        shareImage = [UIImage imageNamed:@"icon"];
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault];
    }
    
    [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:(id)self];
    
    UMSocialSnsPlatform *socialPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    socialPlatform.snsClickHandler(viewControlller,[UMSocialControllerService defaultControllerService],YES);
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSString *platform = [[response.data allKeys] objectAtIndex:0];
        [[UMComDataRequestManager defaultManager] feedShareToPlatform:platform feedId:self.feed.feedID completion:nil];
    }
}

- (BOOL)isWechatInstalled
{
    return ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]);
}


- (BOOL)isQQValid
{
    return ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]);
}

- (NSArray *)sharePlatformIcons
{
    NSMutableArray *platList = [NSMutableArray arrayWithObject:@"um_sina_logo"];
    if ([self isWechatInstalled]) {
        [platList addObjectsFromArray:@[@"um_friend_logo",@"um_wechat_logo"]];
    }
    if ([self isQQValid]) {
        [platList addObjectsFromArray:@[@"um_qzone_logo",@"um_qq_logo"]];
    }
    return platList;
}

- (NSArray *)sharePlatformNames
{
    NSMutableArray *platList = [NSMutableArray arrayWithObject:@"新浪微博"];
    if ([self isWechatInstalled]) {
        [platList addObjectsFromArray:@[@"朋友圈",@"微信"]];
    }
    if ([self isQQValid]) {
        [platList addObjectsFromArray:@[@"Qzone",@"QQ"]];
    }
    return platList;
}

- (NSArray *)sharePlatform
{
    NSMutableArray *platList = [NSMutableArray arrayWithObject:UMShareToSina];
    if ([self isWechatInstalled]) {
        [platList addObjectsFromArray:@[UMShareToWechatTimeline, UMShareToWechatSession]];
    }
    if ([self isQQValid]) {
        [platList addObjectsFromArray:@[UMShareToQzone, UMShareToQQ]];
    }
    return platList;
}


@end
