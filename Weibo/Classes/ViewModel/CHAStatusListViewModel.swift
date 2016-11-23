//
//  CHAStatusListViewModel.swift
//  Weibo
//
//  Created by Wei Zhou on 14/11/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型
/* 
 父类的选择
 
 - 如果类需要 `KVC` 或者字典转模型框架设置对象值，类就需要继承自 NSObject
 - 如果类中只是包装一些代码逻辑（写了一些函数），可以不用任何父类，好处：更加轻量级
 - 提示：如果用 OC 写，一律继承自 NSObject 即可
 
 使命：负责微博的数据处理
 1. 字典转模型
 2. 下拉／上拉刷新数据处理
 */

// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class CHAStatusListViewModel {
    /// 微博模型数据懒加载
    lazy var statusList = [CHAStatus]()
    
    /// 上拉刷新次数
    private var pullUpErrorTimes = 0
    
    
    /// 加载微博列表
    ///
    /// - parameter pullup:       是否上拉刷新标记
    /// - parameter complemetion: 完成回调[网络请求是否成功，是否刷新列表]
    func loadStatus(pullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        
        // 判断是否上拉刷新，同时检查刷新错误
        if pullup && pullUpErrorTimes > maxPullupTryTimes {
            completion(true, false)
            return
        }
        
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        let max_id = !pullup ? 0 : (statusList.last?.id ?? 0)
        
        CHANetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: CHAStatus.self, json: list ?? []) as? [CHAStatus] else {
                completion(isSuccess, false)
                
                return
            }
            
            print("刷新到 \(array.count) 条数据")
            // 2. 拼接数据
            if pullup {
                self.statusList += array
            } else {
                self.statusList = array + self.statusList
            }
            
            // 3. 判断上拉刷新数据量
            if pullup && array.count == 0 {
                self.pullUpErrorTimes += 1
                completion(isSuccess, false)
            } else {
                completion(isSuccess, true)
            }
        }
    }
}
