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
//        print(#function)
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
        // 无法高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        // Swift 调用 OC，返回 instancetype 的方法，无法判断是否可选
//        let btn: UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.lightGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
    
        
}
