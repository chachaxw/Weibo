//
//  CHAHomeViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

// 定义全局常量，尽量使用private修饰
private let cellId = "cellId"

class CHAHomeViewController: CHABaseViewController {
    
    // 微博数据数组
    lazy var statusList = [String]()
    
    
    // 加载数据
    override func loadData() {
        
        // 用网络工具加载数据
        CHANetworkManager.shared.statusList {
            print("加载完成")
        }
        
        // 模拟延迟加载数据 -> dispatch_after
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            for i in 0..<15 {
                
                if self.isPullup {
                    self.statusList.append("上拉 \(i)")
                } else {
                    // 将数据插入到数组的顶部
                    self.statusList.insert(i.description, at: 0)
                }
            }
            print("延迟加载数据")
            
            // 结束刷新
            self.refreshControl?.endRefreshing()
            
            self.isPullup = false
            
            // 刷新表格数据
            self.tableView?.reloadData()
        }
    }
    
    // 显示好友
    @objc func showFriends() {
//        print(#function)
        let vc = CHADemoViewController()
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: -表格数据源方法，具体数据源方法实现，不需要 super
extension CHAHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        // 设置cell
        cell.textLabel?.text = "Halo Chacha \(statusList[indexPath.row])"
        
        return cell
    }
}


// MARK: - 设置界面
extension CHAHomeViewController {
    // 重写父类的方法
    override func setupTableView() {
        super.setupTableView()
        
        // 设置导航栏按钮
        // 无法高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        // Swift 调用 OC，返回 instancetype 的方法，无法判断是否可选
//        let btn: UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.lightGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
        
}
