//
//  CHANetworkManager+Extension.swift
//  Weibo
//
//  Created by Wei Zhou on 02/11/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import Foundation

// 封装新浪微博的网络请求方法
extension CHANetworkManager {
    
    func statusList(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let appId = "843804771"
        let appSecret = "8e74239a2351882884f05e3e5c815e52"

        tokenRequest(URLString: url, parameters: nil) { (json, isSuccess) in
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil 
            let result = json?["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
        
    }
}
