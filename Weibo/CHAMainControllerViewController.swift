//
//  CHAMainViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


// extension 类似于 OC 中的分类，在swift中还可以用来切分代码
// 可以把相近功能的函数，放在一个extension中
// 注：与OC中一样，extension中不能定义属性
// MARK: 设置界面
extension CHAMainViewController {
    // 设置所有子控制器
    private func setupChildControllers() {
        let arr = [
            ["clsName": "CHAHomeViewController", "title": "首页", "imageName": "tabbar_home"],
            ["clsName": "CHAMessageViewController", "title": "消息", "imageName": "tabbar_message_center"],
            ["clsName": "CHADiscoverViewController", "title": "发现", "imageName": "tabbar_discover"],
            ["clsName": "CHAProfileViewController", "title": "我", "imageName": "tabbar_profile"],
        ]
        
        var arrM = [UIViewController]()
        for dict in arr {
            arrM.append(controller(dict: dict))
        }
        
        print(arrM)

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
        
        let nav = CHANavigationViewController(rootViewController: vc)
        
        return nav
    }
    
}
