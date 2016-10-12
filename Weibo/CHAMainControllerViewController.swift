//
//  CHAMainViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupChildControllers()
    }

    // MARK: - 私有按钮
//    private lazy var composeButton: UIButton = UIButton.cz_imageButton(
//        "tabbar_compose_icon_add",
//        backgroundImageName: "tabbar_compose_button"
//    )
}


// extension 类似于 OC 中的分类，在swift中还可以用来切分代码
// 可以把相近功能的函数，放在一个extension中
// 注：与OC中一样，extension中不能定义属性
// MARK: 设置界面
extension CHAMainViewController {
    
    // 设置添加微博按钮
//    private func setupComposeButton() {
//        tabBar.addSubview(composeButton)
//    }
    
    // 设置所有子控制器
    private func setupChildControllers() {
        let arr = [
            ["clsName": "CHAHomeViewController", "title": "首页", "imageName": "home"],
            ["clsName": "CHAMessageViewController", "title": "消息", "imageName": "message_center"],
            ["clsName": "CHADiscoverViewController", "title": "发现", "imageName": "discover"],
            ["clsName": "CHAProfileViewController", "title": "我", "imageName": "profile"],
        ]
        
        var arrM = [UIViewController]()
        for dict in arr {
            arrM.append(controller(dict: dict))
        }
    
        viewControllers = arrM
    }
    
    
    // 使用字典创建一个子控制器
    // parameter dict: 信息字典(clsName, title, imageName)
    //retrun 子控制器
    private func controller(dict: [String: String]) -> UIViewController {
        
        // 1.取得字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["iamgeName"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
        else {
            return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar的颜色和文字
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
//        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontSize], for: <#T##UIControlState#>(rawValue: 0))
        
        let nav = CHANavigationController(rootViewController: vc)
        
        return nav
    }
    
}
