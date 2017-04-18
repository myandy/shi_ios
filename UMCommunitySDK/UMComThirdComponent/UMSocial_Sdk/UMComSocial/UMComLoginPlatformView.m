//
//  UMComLoginPlatformView.m
//  UMCommunity
//
//  Created by wyq.Cloudayc on 7/22/16.
//  Copyright © 2016 Umeng. All rights reserved.
//

#import "UMComLoginPlatformView.h"
#import "UMComResouceDefines.h"
#import "UMComShowToast.h"
#import "UMComProgressHUD.h"
#import <UMComFoundation/UMUtils.h>

#import "UMSocial.h"
#import "WXApi.h"

@interface UMComLoginPlatformView ()


@property (nonatomic, weak) UMComLoginViewController *parentViewController;

@end

@implementation UMComLoginPlatformView

+ (void)plugInViewController:(UMComLoginViewController *)viewController
{
    NSString *className = NSStringFromClass(self);
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil];
    UMComLoginPlatformView *loginPlatformView = xibs[0];
    loginPlatformView.parentViewController = viewController;
    
    [viewController.view addSubview:loginPlatformView];
    
    
    [loginPlatformView setTranslatesAutoresizingMaskIntoConstraints:NO];

    UIView *dependentButton = viewController.registerButton;
    NSDictionary *dict = NSDictionaryOfVariableBindings(loginPlatformView, dependentButton);
    NSDictionary *metrics = @{@"hPadding":@0,@"vPadding":@70,@"bottomPadding":@0};
    NSString *vfl = @"|-hPadding-[loginPlatformView]-hPadding-|";
    NSString *vfl0 = @"V:[dependentButton]-vPadding-[loginPlatformView]-bottomPadding-|";
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:metrics views:dict]];
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl0 options:0 metrics:metrics views:dict]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initPlatformLogin];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initPlatformLogin];
    }
    return self;
}

- (void)initPlatformLogin
{
    self.sinaLoginButton.tag = UMSocialSnsTypeSina;
    self.qqLoginButton.tag = UMSocialSnsTypeMobileQQ;
    self.wechatLoginButton.tag = UMSocialSnsTypeWechatSession;
    
    if ([UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ]) {
        [self.qqLoginButton setImage:UMComImageWithImageName(@"tencentx") forState:UIControlStateNormal];
    }
    if ([UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession]) {
        [self.wechatLoginButton setImage:UMComImageWithImageName(@"wechatx") forState:UIControlStateNormal];
    }
    
    [self.sinaLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.qqLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.wechatLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkWechatInstallStatus
{
    
}

- (void)onClickLogin:(UIButton *)button
{
    NSString *snsName = nil;
    switch (button.tag) {
        case UMSocialSnsTypeSina:
            snsName = UMShareToSina;
            break;
        case UMSocialSnsTypeMobileQQ:
            snsName = UMShareToQQ;
            break;
        case UMSocialSnsTypeWechatSession:
            snsName = UMShareToWechatSession;
            break;
        default:
            break;
    }
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    if (!snsPlatform) {
        [UMComShowToast notSupportPlatform];
        //    } else if ([snsName isEqualToString:UMShareToWechatSession] && ![WXApi isWXAppInstalled]){
        //        [UMComShowToast showNotInstall];
    } else {
        snsPlatform.loginClickHandler(self.parentViewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
            
            __weak typeof(self) ws = self;
            if (response.responseCode == UMSResponseCodeSuccess) {
                [[UMSocialDataService defaultDataService] requestSnsInformation:snsPlatform.platformName completion:^(UMSocialResponseEntity *userInfoResponse) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
                    UMComSnsType snsType = -1;
                    if ([snsPlatform.platformName isEqualToString:UMShareToSina]) {
                        snsType = UMComSnsTypeSina;
                    } else if ([snsPlatform.platformName isEqualToString:UMShareToWechatSession]){
                        snsType = UMComSnsTypeWechat;
                    } else if ([snsPlatform.platformName isEqualToString:UMShareToQQ]){
                        snsType = UMComSnsTypeQQ;
                    }
                    UMComLoginUser *account = [[UMComLoginUser alloc] initWithSnsType:snsType];
                    account.usid = snsAccount.usid;
                    account.custom = @"这是一个自定义字段，可以改成自己需要的数据";
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        if ([userInfoResponse.data valueForKey:@"screen_name"]) {
                            account.name = [userInfoResponse.data valueForKey:@"screen_name"];
                        }
                        if ([userInfoResponse.data valueForKey:@"profile_image_url"]) {
                            account.icon_url = [userInfoResponse.data valueForKey:@"profile_image_url"];
                        }
                        if ([userInfoResponse.data valueForKey:@"gender"]) {
                            account.gender = [userInfoResponse.data valueForKey:@"gender"] ;
                        }
                        if ([snsPlatform.platformName isEqualToString:UMShareToWechatSession]) {
                            if (response.thirdPlatformUserProfile[@"unionid"]) {
                                account.unionId = response.thirdPlatformUserProfile[@"unionid"];
                            }
                        }
                    }
                    
                    UMComProgressHUD *hud = [UMComProgressHUD showHUDAddedTo:self.parentViewController.navigationController.view animated:YES];
                    hud.label.text = UMComLocalizedString(@"um_com_loginingContent",@"登录中...");
                    hud.label.backgroundColor = [UIColor clearColor];
                    [UMComLoginManager requestLoginWithLoginAccount:account requestCompletion:^(NSDictionary *responseObject, NSError *error, dispatch_block_t completion) {
                        [hud hideAnimated:YES];
                        if (error) {
                            [UMComShowToast showFetchResultTipWithError:error];
                        }
                        [ws.parentViewController.navigationController dismissViewControllerAnimated:YES completion:completion];
                    }];
                }];
                
            } else {
                UMLog(@"third platform login not success.");
            }
        });
    }
}


@end
