//
//  CHAStatus.swift
//  Weibo
//
//  Created by Wei Zhou on 14/11/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit
import YYModel

/// 微博数据模型
class CHAStatus: NSObject {
    /// Int 类型，在 64 位机器上是 64 位， 在 32 位机器上是 32 位 
    /// 如果不写 Int64，在 iPad2/iPhone5/iPhone5s/iPhone4s/iPhone4 都无法正常运行
    var id: Int64 = 0
    /// 微博信息内容
    var text: String?
    
    /// 重写 description 的计算属性
    override var description: String {
        return yy_modelDescription()
    }
}
