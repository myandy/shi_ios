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
        static var COPY_SUCCESS : String { return NSLocalizedString("文本已经复制到剪切板", comment: "") }
        static var COLLECTION_SUCCESS: String { return NSLocalizedString("收藏成功", comment: "") }
        static var CANCEL_COLLECTION_SUCCESS: String { return NSLocalizedString("取消收藏成功", comment: "") }
    }
    struct Duishi {
        static var duishi                       : String { return NSLocalizedString("对诗", comment: "") }
        static var refresh                       : String { return NSLocalizedString("刷新", comment: "") }
    }
    
    struct Common {
        static let CONFIRM = "确定"
        static let CANCEL = "取消"
        static let DELETE = "删除"
        static let EDIT = "编辑"
    }

    struct All {
         static let DYNASTIES = ["全部朝代","先秦","汉朝","魏晋","南北朝","唐朝","北宋","南宋","元朝","明朝","清朝","近代","当代"]
         static let CHOOSE_DYNASTY = "选择朝代"
         static let SORT_ORDER = ["默认排序","按诗数量排序"]
        
        static let FAVORITE = "收藏"
        static let DIRECTORY = "目录"
        static let COPY_CONTENT = "复制内容"
        static let SPEAK_CONTENT = "语音朗读"
        static let AUTHOR_PEDIA = "作者百科"
        static let CONTENT_PEDIA = "内容百科"
        static let MENU_EXIT = "退出"
    }
    
    struct Tips {
        static let AUTHOR_SLIDE = "右滑可以关闭，左滑看下一页"
    }
    
    struct Main {
        static let INTRO = "诗Shi介绍"
    }

    struct Setting {
        static let YUN_TITLE = "韵典"
        static let YUN_CHOICES = ["中华新韵","平水韵","词林正韵"]

        static let CHECK_TITLE = "检查平仄"
        static let CHECK_CHOICES = ["自动检查","不自动检查"]

        static let FONT_TITLE = "字体"
        static let FONT_CHOICES = ["简体","繁体","默认字体"]
        
        static let AUTHOR_TITLE = "作者名"
        
        static let ABOUT_TITLE = "关于"
        static let MARK_TITLE = "给我打分"
        static let WEIBO_TITLE = "关注微博"
        
        static let ABOUT_LABEL = "关于诗Shi"
        static let ABOUT_QQ = "官方QQ群：305395176"
        static let ABOUT_INTRO = "本应用为非盈利个人应用，设计风格借鉴于词Ci。之前开发了词Ci android版，应用户的建议再开发了本应用。"
        static let ABOUT_EMAIL = "有建议或者bug请联系：\n".appending(ABOUT_EMAIL_VALUE)
        static let ABOUT_EMAIL_VALUE = "andymao1991@gmail.com"
        static let ABOUT_WEXIN = "微信公众号：天涯共词Ci"
        static let ABOUT_VERSION = "当前版本："

        static let USERNAME_TITLE = "作者名"
        static let USERNAME_CONTENT = "请输入作者名"
        static let USERNAME_HINT = "作者名"

    }

    struct Search {
         static let SEARCH_AUTHOR_HINT = "搜索诗人"
         static let SEARCH_POETRY_HINT = "搜索诗"
         static let YUN_SEARCH_HINT = "在 %@ 中搜索"
        
        static let SEARCH_WRITING_HINT = "搜索作品"
        static let SEARCH_COLLECT_HINT = "搜索收藏夹"
    }

    struct FormerEdit {
         static let former_name = "格律名"
         static let former_intro = "格律介绍"
         static let former_pingze = "平仄"
         static let former_add_value_null = "格律名和平仄不能为空"
         static let manual = "自定义"
         static let no_limit = "不限"
    }
    
    struct Edit {
        static let INPUT_TITLE = "输入标题"
    }

    struct Share {
        static let SHARE = "分享"
        static let COPY_TEXT = "复制文本"
        static let COPY_SUC = "复制成功"
        static let SAVE_IMAGE = "保存图片"
        static let INCREASE_FONTSIZE = "增大字体"
        static let REDUCE_FONTSIZE = "减小字体"
        static let SAVE_SUC = "保存成功"
        static let SAVE_FAIL = "保存失败"
        static let TEXT_ALIGN = "文字居中/居左"
        static let CONTENT_MOVELEFT = "内容左移"
        static let CONTENT_MOVERIGHT = "内容右移"
        static let HIDE_AHTHOR = "隐藏作者"
    }
    
    struct AuthorPager {
        
    }
}
