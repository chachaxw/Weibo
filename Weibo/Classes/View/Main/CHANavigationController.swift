
//  CHANavigationViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHANavigationController: UINavigationController {
    
    // 重写 push 方法，所有的 push 动作都会调用这个方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        print(viewController)
        
        // 如果不是栈底控制器才需要隐藏底部 tabBar，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }
}
