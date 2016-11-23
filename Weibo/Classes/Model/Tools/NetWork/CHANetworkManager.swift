//
//  CHANetworkManager.swift
//  Weibo
//
//  Created by Wei Zhou on 24/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit
import AFNetworking

// swift 枚举支持任意类型
enum CHAHTTPMethod {
    case GET
    case POST
}

class CHANetworkManager: AFHTTPSessionManager {
    
    // 在第一次访问时，执行闭包，并将结果保存在 shared 中
    static let shared = CHANetworkManager()
    
    /// 访问令牌，所有网络请求，都基于此令牌
    var accessToken: String? = "2.00DxjDHE04KWGv771112e59bQ63h1C"
    
    let uid: String? = "3768857305"
    
    /// 专门负责拼接 token 的网络请求方法
    func tokenRequest(method: CHAHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?,
        completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        // 处理 token 字段
        guard let token = accessToken else {
            // FIXME: 发送通知，提示用户登录（本方法不知道被谁调用，谁接收到通知，谁处理）
            print("没有 token! 需要登录")
            completion(nil, false)
            
            return
        }
        
        // 1> 判断 token 是否为 nil，为 nil 直接返回
        var parameters = parameters
        if parameters == nil {
            // 实例化字典
            parameters = [String: AnyObject]()
        }
        
        // 2> 设置参数字典，代码在此处字典一定有值
        parameters!["access_token"] = token as AnyObject?
        
        // 调用 request 发起真正的网络请求方法
        request(URLString: URLString, parameters: parameters!, completion: completion)
        
    }
    
    // 封装 AFN 的 GET/POST 请求
    /// - parameter method:      GET/POST
    /// - parameter URLString:   URLString
    /// - parameter parameters:  参数字典
    /// - parameter completion:  完成回调[json(字典/数组), 是否成功]
    func request(method: CHAHTTPMethod = .GET, URLString: String, parameters: [String: Any], completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(json as AnyObject?, true)
        }
        
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            
            // 针对 403 处理用户 token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                
                // FIXME: 发送通知（本方法不知道被谁调用，谁接收到通知，谁处理）
            }
            
            print("网络错误\(error)")
            
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
    // 返回微博的未读数量
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        guard let uid = uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let params = ["uid": uid]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
}
