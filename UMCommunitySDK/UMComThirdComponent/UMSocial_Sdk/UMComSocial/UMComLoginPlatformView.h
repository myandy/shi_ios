//
//  UMComLoginPlatformView.h
//  UMCommunity
//
//  Created by wyq.Cloudayc on 7/22/16.
//  Copyright © 2016 Umeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMComLoginViewController.h"

@interface UMComLoginPlatformView : UIView

/**
 *  platform login
 */
@property (nonatomic, weak) IBOutlet UIButton *sinaLoginButton;
@property (nonatomic, weak) IBOutlet UIButton *qqLoginButton;
@property (nonatomic, weak) IBOutlet UIButton *wechatLoginButton;


+ (void)plugInViewController:(UMComLoginViewController *)viewController;

@end
