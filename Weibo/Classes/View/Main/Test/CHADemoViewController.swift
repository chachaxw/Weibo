//
//  CHADemoViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 14/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHADemoViewController: CHABaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
        view.backgroundColor = UIColor.cz_random()
    }
    
    @objc func showNext() {
        let vc = CHADemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension CHADemoViewController {
    
    override func setupUI() {
        
        // 设置右侧的控制器
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
    }
}
