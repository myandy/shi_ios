//
//  AppDelegate.swift
//  shishi
//
//  Created by andymao on 16/11/9.
//  Copyright © 2016年 andymao. All rights reserved.
//

import UIKit
import UMCommunitySDK
import Bugly


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        copyDbToSandy()
        
        UserDBManager.default.configure()
        
        UMCommunitySDK.setAppkey("58a306bdb27b0a1e7f000d5f", withAppSecret: "2afbfe1210241b0baeb9d09524ebcce7")
       

        UMSocialQQHandler.setQQWithAppId("1104581811" , appKey: "lj8gnlPCd4j4vA22", url: "test")
        UMSocialWechatHandler.setWXAppId("944955993", appSecret: "4b6e97140e9417bec7b225bc4477262d", url: "test")
        UMSocialSinaSSOHandler.openNewSinaSSO(withAppKey: "944955993", secret: "4b6e97140e9417bec7b225bc4477262d", redirectURL: "http://sns.whalecloud.com/sina2/callback")

        
        Bugly.start(withAppId: "8511d2df86", config: nil)

        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    let databaseFileName = "shishi.db"
    
    func copyDbToSandy(){
        
        //声明一个Documents下的路径
        let dbPath = NSHomeDirectory() + "/Documents/shishi.db"
//        let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
//                                                                NSSearchPathDomainMask.UserDomainMask, true)
//        let documnetPath = documentPaths[0] as! String
        NSLog(dbPath)
        //判断数据库文件是否存在
        if !FileManager.default.fileExists(atPath: dbPath){
            //获取安装包内数据库路径
            let bundleDBPath:String? = Bundle.main.path(forResource: "shishi", ofType: "db")
            //将安装包内数据库拷贝到Documents目录下
            
            do {
                try FileManager.default.copyItem(atPath: bundleDBPath!, toPath: dbPath)
            }
            catch{
                NSLog("failed")
            }
            
        }
        else{
            NSLog("db exist!")
        }
        
        
       
    }

}

