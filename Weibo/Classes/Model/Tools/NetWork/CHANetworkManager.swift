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
    
    // 封装 AFN 的 GET/POST 请求
    /// - parameter method:      GET/POST
    /// - parameter URLString:   URLString
    /// - parameter parameters:  参数字典
    /// - parameter completion:  完成回调[json(字典/数组), 是否成功]
    func request(method: CHAHTTPMethod = .GET, URLString: String, parameters: [String: Any], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(json, true)
        }
        
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络错误\(error)")
            
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
}
