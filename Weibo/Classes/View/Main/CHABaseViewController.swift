//
//  CHABaseViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 06/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

// OC中使用协议来替代多继承
// Swift 的写法更类似于多继承
// Swift 中，利用 extension 可以把函数按照功能分类管理，便于阅读和管理
// 注意：
// 1. extension 不能有属性
// 2. extension 中不能重写父类方法！重写父类方法，是子类的职责，扩展是对类的扩展


// 所有主控制器的积累控制器
class CHABaseViewController: UIViewController {
    
    var tableView: UITableView?
    
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    // 自定义导航条目，以后设置导航条目统一用 navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }
    
    // 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // 加载数据
    func loadData() {
        
    }
    
}

// MARK - 设置界面
extension CHABaseViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        
        // 取消自动缩进， 如果隐藏了导航栏，会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupNaviagtionBar()
        setupTableView()
    }
    
    // 设置导航条
    func setupNaviagtionBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将 item 设置给 bar
        navigationBar.items = [navItem]
        // 设置 navBar 的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 设置 navBar 的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
    }
    
    // 设置表格视图
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源 & 代理 -> 目的：子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩紧
        tableView?.contentInset = UIEdgeInsetsMake(navigationBar.bounds.height, 0, (tabBarController?.tabBar.bounds.height)!, 0)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CHABaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类知识准备方法，子类负责具体的实现
    // 子类数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是为了保证没有语法错误
        return UITableViewCell()
    }
    
    
}


