//
//  SSStr.swift
//  shishi
//
//  Created by tb on 2017/5/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSStr: NSObject {
    struct Toast {
        static var COPY_SUCCESS : String = "文本已经复制到剪切板".fixLanguage()
        static var COLLECTION_SUCCESS: String = "收藏成功".fixLanguage()
        static var CANCEL_COLLECTION_SUCCESS: String = "取消收藏成功".fixLanguage()
    }
    struct Duishi {
        static var duishi                       : String = "对诗".fixLanguage()
        static var refresh                       : String = "刷新".fixLanguage()
    }
    
    struct Common {
        static let CONFIRM = "确定".fixLanguage()
        static let CANCEL = "取消".fixLanguage()
        static let DELETE = "删除".fixLanguage()
        static let EDIT = "编辑".fixLanguage()
    }

    struct All {
        static let DYNASTIES = ["全部朝代","先秦","汉朝","魏晋","南北朝","唐朝","北宋","南宋","元朝","明朝","清朝","近代","当代"].map { (text) in
            return text.fixLanguage()
        }
         static let CHOOSE_DYNASTY = "选择朝代".fixLanguage()
        static let SORT_ORDER = ["默认排序","按诗数量排序"].map { (text) in
            return text.fixLanguage()
        }
        
        static let FAVORITE = "收藏".fixLanguage()
        static let DIRECTORY = "目录".fixLanguage()
        static let COPY_CONTENT = "复制内容".fixLanguage()
        static let SPEAK_CONTENT = "语音朗读".fixLanguage()
        static let AUTHOR_PEDIA = "作者百科".fixLanguage()
        static let CONTENT_PEDIA = "内容百科".fixLanguage()
        static let MENU_EXIT = "退出".fixLanguage()
    }
    
    struct Tips {
        static let AUTHOR_SLIDE = "右滑可以关闭，左滑看下一页".fixLanguage()
    }
    
    struct Main {
        static let INTRO = "诗Shi介绍".fixLanguage()
    }

    struct Setting {
        static let YUN_TITLE = "韵典".fixLanguage()
        static let YUN_CHOICES = ["中华新韵","平水韵","词林正韵"].map { (text) in
            return text.fixLanguage()
        }

        static let CHECK_TITLE = "检查平仄".fixLanguage()
        static let CHECK_CHOICES = ["自动检查","不自动检查"].map { (text) in
            return text.fixLanguage()
        }

        static let FONT_TITLE = "字体".fixLanguage()
        static let FONT_CHOICES = [FONT_SIMPLIFIEDCHINESE, FONT_TRADITIONALCHINESE, FONT_DEFAULT]
        static let FONT_SIMPLIFIEDCHINESE = "简体".fixLanguage()
        static let FONT_TRADITIONALCHINESE = "繁体".fixLanguage()
        static let FONT_DEFAULT = "默认字体".fixLanguage()
        
        static let AUTHOR_TITLE = "作者名".fixLanguage()
        

        static let ABOUT_TITLE = "关于".fixLanguage()
        static let MARK_TITLE = "给我打分".fixLanguage()
        static let WEIBO_TITLE = "关注微博".fixLanguage()
        static let SHARE_TITLE = "分享给好友"
        
        static let ABOUT_LABEL = "关于诗Shi".fixLanguage()
        static let ABOUT_QQ = "官方QQ群：683485775".fixLanguage()
        static let ABOUT_INTRO = "诗Shi".fixLanguage()
        static let ABOUT_EMAIL = "有建议或者bug请联系：\n".appending(ABOUT_EMAIL_VALUE).fixLanguage()
        static let ABOUT_EMAIL_VALUE = "andymao1991@gmail.com".fixLanguage()
        static let ABOUT_WEXIN = "微信公众号：天涯共词Ci".fixLanguage()
        static let ABOUT_VERSION = "当前版本：".fixLanguage()

        
        
//        static let ABOUT_LABEL = "关于诗Shi"
//        static let ABOUT_QQ = "官方QQ群：683485775"
////        static let ABOUT_INTRO = "诗Shi"
//        static let ABOUT_EMAIL = "有建议或者bug请联系：\n".appending(ABOUT_EMAIL_VALUE)
//        static let ABOUT_EMAIL_VALUE = "andymao1991@gmail.com"
//        static let ABOUT_WEXIN = "微信公众号：天涯共词Ci"
//        static let ABOUT_VERSION = "当前版本："


        static let USERNAME_TITLE = "作者名".fixLanguage()
        static let USERNAME_CONTENT = "请输入作者名".fixLanguage()
        static let USERNAME_HINT = "作者名".fixLanguage()

    }

    struct Search {
         static let SEARCH_AUTHOR_HINT = "搜索诗人".fixLanguage()
         static let SEARCH_POETRY_HINT = "搜索诗".fixLanguage()
         static let YUN_SEARCH_HINT = "在 %@ 中搜索".fixLanguage()
        
        static let SEARCH_WRITING_HINT = "搜索作品".fixLanguage()
        static let SEARCH_COLLECT_HINT = "搜索收藏夹".fixLanguage()
    }

    struct FormerEdit {
         static let former_name = "格律名".fixLanguage()
         static let former_intro = "格律介绍".fixLanguage()
         static let former_pingze = "平仄".fixLanguage()
         static let former_add_value_null = "格律名和平仄不能为空".fixLanguage()
         static let manual = "自定义".fixLanguage()
         static let no_limit = "不限".fixLanguage()
    }
    
    struct Edit {
        static let INPUT_TITLE = "输入标题".fixLanguage()
    }

    struct Share {
        static let SHARE = "分享".fixLanguage()
        static let COPY_TEXT = "复制文本".fixLanguage()
        static let COPY_SUC = "复制成功".fixLanguage()
        static let SAVE_IMAGE = "保存图片".fixLanguage()
        static let INCREASE_FONTSIZE = "增大字体".fixLanguage()
        static let REDUCE_FONTSIZE = "减小字体".fixLanguage()
        static let SAVE_SUC = "保存成功".fixLanguage()
        static let SAVE_FAIL = "保存失败".fixLanguage()
        static let TEXT_ALIGN = "文字居中/居左".fixLanguage()
        static let CONTENT_MOVELEFT = "内容左移".fixLanguage()
        static let CONTENT_MOVERIGHT = "内容右移".fixLanguage()
        static let HIDE_AHTHOR = "显示/隐藏作者".fixLanguage()
    }
    
    struct AuthorPager {
        
    }
}
