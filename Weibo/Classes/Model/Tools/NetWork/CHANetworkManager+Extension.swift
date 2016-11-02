//
//  CHANetworkManager+Extension.swift
//  Weibo
//
//  Created by Wei Zhou on 02/11/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import Foundation

extension CHANetworkManager {
    
    func statusList(completion: () -> ()) {
        let url = "https://api.weibo.com/2/statuses/public_timeline.json"
        let token = ["access_token": "hello"]
        
        request(URLString: url, parameters: token) { (json, isSuccess) in
            print(json)
        }
    }
}
