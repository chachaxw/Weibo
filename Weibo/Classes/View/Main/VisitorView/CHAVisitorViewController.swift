//
//  CHAVisitorViewController.swift
//  Weibo
//
//  Created by Wei Zhou on 17/10/2016.
//  Copyright © 2016 Wei Zhou. All rights reserved.
//

import UIKit

class CHAVisitorViewController: UIView {

    // MARK - 使用字典设置访客视图的信息
    // parameter dict: [imageName / message]
    // 提示： 如果是首页，imageName == ""
    var visitorInfo: [String: String]? {
        didSet {
            // 1. 取字典信息
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"]
            else {
                return
            }
            
            tipLabel.text = message
            
            if imageName == "" {
                return
            }
            
            iconView.image = UIImage(named: imageName)
        }
    }
    
    // MARK - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been impleented")
    }

    
    // MARK - 私有控件
    lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
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
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // 1. 添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registorButton)
        addSubview(loginButton)
        
        // 2. 取消 autoresizing 
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin: CGFloat = 20
        
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
        
        // tipLabel
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        // registorButton
        addConstraint(NSLayoutConstraint(item: registorButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registorButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registorButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        // loginButton
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registorButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // maskIconView
        // views参数：定义 VFL 中的控件名称和实际名称映射关系
        let viewDict = ["maskIconView": maskIconView, "registorButton": registorButton] as [String : Any]
        let metrics = ["spacing": -35]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registorButton]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
    
}
