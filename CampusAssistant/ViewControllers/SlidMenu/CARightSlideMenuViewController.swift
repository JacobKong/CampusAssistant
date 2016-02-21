
//
//  CARightSlideMenuViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/21.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CARightSlideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBgImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupBgImage(){
        let imageView = UIImageView.init(frame: self.view.frame)
        imageView.image = UIImage(named: "slide_menu_bg")
        self.view.addSubview(imageView)
    }
}
