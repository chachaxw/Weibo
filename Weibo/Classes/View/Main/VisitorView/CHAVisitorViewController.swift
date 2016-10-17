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
    
}

extension CHAVisitorViewController {
    func setupUI() {
        backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
}
