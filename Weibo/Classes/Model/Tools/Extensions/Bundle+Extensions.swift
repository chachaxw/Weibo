//
//  Bundle+Extensions.swift
//  反射机制
//
//  Created by Wei Zhou on 11/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import Foundation

extension Bundle {
    
    // 计算型属性类似于函数，没有参数，有返回值，这里返回的是命名空间字符串
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
