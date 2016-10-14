
//  CHANavigationViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHANavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    // 重写 push 方法，所有的 push 动作都会调用这个方法
    // viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        print(viewController)
        
        // 如果不是栈底控制器才需要隐藏底部 tabBar，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器类型
            if let vc = viewController as? CHABaseViewController {
                
                var title = "返回"
                
                // 判断控制器的级数
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 取出自定义的navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func popToParent() {
        popViewController(animated: true)
    }
}
