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
        
        // 添加子控制器
        setupChildControllers()
        setupComposeButton()
        
    }
    
    // MARK - 监听方法
    // 撰写微博
    // private 能够保证方法私有，仅在当前对象被访问
    // @objc 允许这个函数运行时通过 OC 的消息机制被调用
    @objc private func composeStatus() {
        print("撰写微博")
    }
    
    // MARK: - 私有控件
    private lazy var composeButton: UIButton = UIButton.cz_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button"
    )
    
    // 设置添加微博按钮
    func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 设置按钮的位置
        let count = CGFloat(childViewControllers.count)
        // 向内缩进的宽度减少，能够让按钮的宽度增加，盖住容错点，防止穿帮
        let w = tabBar.bounds.width / count - 1
        
        // CGRectInset 正数向内缩紧，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
}


// extension 类似于 OC 中的分类，在swift中还可以用来切分代码
// 可以把相近功能的函数，放在一个extension中
// 注：与OC中一样，extension中不能定义属性
// MARK: 设置界面
private extension CHAMainViewController {
    
    // 设置所有子控制器
    func setupChildControllers() {
        let array = [
            ["clsName": "CHAHomeViewController", "title": "首页", "imageName": "home"],
            ["clsName": "CHAMessageViewController", "title": "消息", "imageName": "message_center"],
            ["clsName": "UIViewController"],
            ["clsName": "CHADiscoverViewController", "title": "发现", "imageName": "discover"],
            ["clsName": "CHAProfileViewController", "title": "我", "imageName": "profile"],
            ]
        
        var arrM = [UIViewController]()
        for dict in array {
            arrM.append(controller(dict: dict))
        }
        
        viewControllers = arrM
    }
    
    
    // 使用字典创建一个子控制器
    // parameter dict: 信息字典(clsName, title, imageName)
    // retrun 子控制器
    func controller(dict: [String: String]) -> UIViewController {
        
        // 1.取得字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            // AnyClass? -> 视图控制器类型
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
            else {
                return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar的颜色和文字
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
//      vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        let nav = CHANavigationController(rootViewController: vc)
        
        return nav
    }
    
}
