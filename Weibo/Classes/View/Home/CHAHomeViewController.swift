//
//  CHAHomeViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAHomeViewController: CHABaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // 显示好友
    @objc func showFriends() {
        print(#function)
        let vc = CHADemoViewController()
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension CHAHomeViewController {
    // 重写父类的方法
    override func setupUI() {
        super.setupUI()
        
        // 设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
    }
    
        
}
