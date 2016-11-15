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

class CHAStatusListViewModel {
    /// 微博模型数据懒加载
    lazy var statusList = [CHAStatus]()
    
    /// 加载微博列表
    ///
    /// - parameter complemetion: 完成回调
    func loadStatus(completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        let since_id = statusList.first?.id ?? 0
        
        CHANetworkManager.shared.statusList(since_id: since_id, max_id: 0) { (list, isSuccess) in
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: CHAStatus.self, json: list ?? []) as? [CHAStatus] else {
                completion(isSuccess)
                
                return
            }
            
            // 2. 拼接数据
            self.statusList = array + self.statusList
            
            // 3. 完成回调
            completion(isSuccess)
        }
    }
}
