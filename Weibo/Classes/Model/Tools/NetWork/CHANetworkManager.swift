//
//  CHANetworkManager.swift
//  Weibo
//
//  Created by Wei Zhou on 24/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit
import AFNetworking

class CHANetworkManager: AFHTTPSessionManager {
    
    // 在第一次访问时，执行闭包，并将结果保存在 shared 中
    static let shared = CHANetworkManager()
}
