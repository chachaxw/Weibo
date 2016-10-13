//
//  AppDelegate.swift
//  Weibo
//
//  Created by Wei Zhou on 05/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // window 为可选
    var window: UIWindow?
    
    /*
     1. Swift中的命名空间
        - 在同一个命名空间下，全局共享
        - 第三方框架使用 Swift 如果直接拖拽到项目中，从属于同一个命名空间，很有可能冲突
        - 尽量使用 cocopod 安装第三方框架
     2. Swift中NSClassFromString(发射机制) 的写法
        - 反射的目的是为了解耦
        - 搜索 “反射机制和工厂方法”
        - 封装的好，弹性很大
    */
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sleep(1)
        
        // 代码中的问号都是可选解包，发送消息，不参与计算
        // 所有的 ? 都是Xcode自动添加的
        // 1.创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        // --- 输出 Bundle info.plist 的内容
        // [String: AnyObject]?
        // print(Bundle.main.infoDictionary, Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")
        // 1. 因为字典是可选的，因此需要解包再取值
        //    字典为nil，就不取值
        // 2. 通过key从字典中取值，AnyObject? 表示不一定能够获取到值
        
        
        // 2.创建根控制器
        window?.rootViewController = CHAMainViewController()
        
        // 3.显示界面
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

