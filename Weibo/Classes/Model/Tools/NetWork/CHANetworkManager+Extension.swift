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
    
    /// 加载微博数据字典
    ///
    /// - parameter slice_id:    返回ID比since_id大的微博（即比since_id时间晚的微博）
    /// - parameter max_id:      返回ID小于或等于max_id的微博
    /// - parameter completion:  完成回调[json(字典/数组), 是否成功]
    func statusList(since_id: Int64, max_id: Int64, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"

        let params = ["since_id": "\(since_id)", "max_id": "\(max_id)"]
        
        tokenRequest(URLString: url, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil
            let result = json?["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
        
    }
}
