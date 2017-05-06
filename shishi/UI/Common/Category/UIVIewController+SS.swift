//
//  UIVIewController+LEO.swift
//  LoginModule
//
//  Created by Dean on 2016/10/24.
//  Copyright © 2016年 Dean. All rights reserved.
//

import UIKit
import ReachabilitySwift
import MBProgressHUD



//  显示错误信息
extension UIViewController {
    
    func isTopViewController() -> Bool {
        return self.isViewLoaded && self.view.window != nil
    }
  
}



extension UIViewController {
    //显示进度条
    public func showProgressHUD(){

        self.hideProgressHUD()
        
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    //隐藏进度条
    public func hideProgressHUD(forView addToView: UIView? = nil){
        if let _ = self.hud {
            MBProgressHUD.hide(for: addToView ?? self.view, animated: true)
            self.hud = nil
        }
        
    }
    
    
    
    //显示下载进度条
    public func showDownloadingProgressHud(progress: Float, addToView: UIView? = nil) {
        showProgressHud(progress: progress, title: "downloading", addToView: addToView)
    }
    
    
    //显示带进度值的进度条
    public func showProgressHud(progress: Float, title: String, addToView: UIView? = nil) {
        var needCreate = true
        if let hud = self.hud, hud.mode == .annularDeterminate{
            needCreate = false
        }
        
        let progressViewWidth:CGFloat = 60
        if needCreate {
            self.hideProgressHUD()
            
            self.hud = MBProgressHUD.showAdded(to: addToView ?? self.view, animated: true)
            self.hud!.mode = .annularDeterminate
            self.hud!.label.text = title
            self.hud!.label.textColor = SSTheme.Color.C6
            self.hud!.minSize = CGSize(width: 200, height: 150)
            
            if let indicatorView = self.hud!.value(forKey: "indicator") as? MBRoundProgressView {
                indicatorView.progressTintColor = SSTheme.Color.C9
            }
        }
        
        self.hud!.progress = progress
        self.hud!.layoutIfNeeded()
        
        if let indicatorView = self.hud!.value(forKey: "indicator") as? MBRoundProgressView {
            
            let constraints = indicatorView.constraints
            log.debug(constraints)
            for cons in constraints {
                if cons.constant != progressViewWidth {
                    cons.constant = progressViewWidth
                }
                
            }
        }
        
        if let paddingConstraints = self.hud!.value(forKey: "paddingConstraints") as? [NSLayoutConstraint] {
            let index = paddingConstraints.index(where: { [unowned self] (constraint) -> Bool in
                constraint.firstItem === self.hud!.label
            })
            
            let labelTopPadding:CGFloat = 15
            if let itemIndex = index, paddingConstraints[itemIndex].constant != labelTopPadding {
                paddingConstraints[itemIndex].constant = labelTopPadding
            }
        }
        
    }
    
    
    
    private struct AssociatedKeys {
        static var hudKey = "hudKey"
        static var downloadProgressViewKey = "downloadProgressViewKey"
    }
    
    var hud: MBProgressHUD? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hudKey) as? MBProgressHUD
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.hudKey,
                newValue as MBProgressHUD?,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var downloadProgressView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.downloadProgressViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.downloadProgressViewKey,
                newValue as UIView?,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
