//
//  CHAMainViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAMainViewController: UITabBarController {
    
    // 定时器
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控制器
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        // 未读微博数量
        CHANetworkManager.shared.unreadCount{ (count) in
            print("有 \(count) 条微博未读")
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    /* 
       - 用代码控制设备的方向，可以在需要横屏的地方，单独处理
       - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
       - 如果播放视频，通常是通过modal来展现的
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK - 监听方法
    // 撰写微博
    // private 能够保证方法私有，仅在当前对象被访问
    // @objc 允许这个函数运行时通过 OC 的消息机制被调用
    @objc func composeStatus() {
        print("撰写微博")
        
        // 测试旋转方向
        let vc = UIViewController()
        
        vc.view.backgroundColor = UIColor.black
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - 私有控件
    lazy var composeButton: UIButton = UIButton.cz_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button"
    )
    
}


// MARK - 与时钟相关的方法
extension CHAMainViewController {
    
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// 时钟触发方法
    @objc fileprivate func updateTimer() {
        CHANetworkManager.shared.unreadCount { (count) in
            // 设置首页 tabBarItem 的 badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
        }
    }
}

// extension 类似于 OC 中的分类，在swift中还可以用来切分代码
// 可以把相近功能的函数，放在一个extension中
// 注：与OC中一样，extension中不能定义属性
// MARK: 设置界面
extension CHAMainViewController {
    
    // 设置所有子控制器
    func setupChildControllers() {
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        var data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        guard let array = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String: Any]]
            else {
                return
        }
        
        // 从 bundle 中加载配置json
        // 1. 路径 2. 加载 NSData 3. 反序列化转化为成数组
//        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
//            let data = NSData(contentsOfFile: path),
//            let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String: Any]]
//            else {
//                return
//        }
//        print(data)
        
//        let array: [[String: Any]] = [
//            ["clsName": "CHAHomeViewController", "title": "首页", "imageName": "home",
//                "visitorInfo": ["imageName": "", "message": "关注一些人，回这里看看有什么"]
//            ],
//            ["clsName": "CHAMessageViewController", "title": "消息", "imageName": "message_center",
//                "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "登录后，别人评论你的微博，发给你的消息，都会在这里收到消息"]
//            ],
//            ["clsName": "UIViewController"],
//            ["clsName": "CHADiscoverViewController", "title": "发现", "imageName": "discover",
//                "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"]
//            ],
//            ["clsName": "CHAProfileViewController", "title": "我", "imageName": "profile",
//                "visitorInfo": ["imageName": "visitordiscover_image_profile", "message": "登录后，你的微博、相册、个人资料会显示在这里，展示给别人"]
//            ],
//        ]
        
        var arrM = [UIViewController]()
        for dict in array! {
            arrM.append(controller(dict: dict))
        }
        
        viewControllers = arrM
    }
    
    
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
    
    // 使用字典创建一个子控制器
    // parameter dict: 信息字典(clsName, title, imageName, visitorInfo)
    // retrun 子控制器
    func controller(dict: [String: Any]) -> UIViewController {
        
        // 1.取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            // AnyClass? -> 视图控制器类型
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? CHABaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String]
        else {
            return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 设置控制器的访客字典
        vc.visitorInfoDict = visitorDict
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar的颜色和文字
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
//      vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        // 实例化导航控制器的时候，会调用push方法，将 rootVC 压栈
        let nav = CHANavigationController(rootViewController: vc)
        
        return nav
    }
    
}
