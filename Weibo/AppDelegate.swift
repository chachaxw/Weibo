//
//  AppDelegate.swift
//  Weibo
//
//  Created by Wei Zhou on 05/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit
import UserNotifications

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
        
        // #avaliable 检测设备版本
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权 " + (success ? "成功" : "失败"))
            }
        } else {
            // Fallback on earlier versions
            // 取得用户授权显示通知(上方的提示框／声音／BadgeNumber)
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(notifySettings)
        }

        
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
        
        loadAppInfo()
        
        return true
    }
    
}


private extension AppDelegate {
    
    func loadAppInfo() {
        
        // 从模块异步获取
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            let data = NSData(contentsOf: url!)
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            // 直接保存在沙盒中，等待下一次程序使用！
            data?.write(toFile: jsonPath, atomically: true)
            print("运用程序加载完毕 \(jsonPath)")
        }
        
    }
}
