//
//  CHAVisitorViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 17/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAVisitorViewController: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been impleented")
    }
    
    // MARK - 私有控件
    lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    lazy var houseView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    
    lazy var registorButton: UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
    lazy var loginButton: UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.darkGray,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
}

extension CHAVisitorViewController {
    func setupUI() {
        backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        // 1. 添加控件
        addSubview(iconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registorButton)
        addSubview(loginButton)
        
        // 2. 取消 autoresizing 
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3. 自动布局
        // iconView
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        
        // houseView
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
    }
    
}
