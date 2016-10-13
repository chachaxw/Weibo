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
        view.backgroundColor = UIColor.cz_random()
    }
    
}


extension CHABaseViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.cz_random()
    }
}
