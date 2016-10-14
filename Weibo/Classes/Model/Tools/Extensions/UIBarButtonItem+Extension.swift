//
//  UIBarButtonItem+Extension.swift
//  Weibo
//
//  Created by Wei Zhou on 14/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem 
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize, 默认为16
    /// - parameter target:   target
    /// - parameter action:   action
    /// - parameter isBack:   是否是返回按钮，如果是则加上箭头
    /// - return: UIBarButtonItem 
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject, action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // self.init 事例化 UIBarButtonItem
        self.init(customView: btn)
    }
}
