//
//  SSStr.swift
//  shishi
//
//  Created by tb on 2017/5/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSStr: NSObject {
    struct Duishi {
        static var duishi                       : String { return NSLocalizedString("DUISHI", comment: "") }
        static var refresh                       : String { return NSLocalizedString("REFRESH", comment: "") }
    }

    struct All {
         static let DYNASTIES = ["全部朝代","先秦","汉朝","魏晋","南北朝","唐朝","北宋","南宋","元朝","明朝","清朝","近代","当代"]
         static let CHOOSE_DYNASTY = "选择朝代"
         static let SORT_ORDER = ["默认排序","按诗数量排序"]
    }

    struct Setting {
        static let YUN_TITLE = "韵典"
        static let YUN_CHOICES = ["中华新韵","平水韵","词林正韵"]
        static let FONT_TITLE = "字体切换"
        static let FONT_CHOICES = ["简体","繁体","默认字体"]
        static let CHECK_TITLE = "检查平仄"
        static let CHECK_CHOICES = ["自动检查","不自动检查"]

    }

    struct Search {
         static let SEARCH_AUTHOR_HINT = "搜索诗人"
         static let SEARCH_POETRY_HINT = "搜索诗"
         static let YUN_SEARCH_HINT = "在 %@ 中搜索"
    }

    struct FormerEdit {
         static let former_name = "格律名"
         static let former_intro = "格律介绍"
         static let former_pingze = "平仄"
         static let former_add_value_null = "格律名和平仄不能为空"
         static let manual = "自定义"
         static let no_limit = "不限"
    }

}
