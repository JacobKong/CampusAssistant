//
//  CAIPWGSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAIPWGSectionView: UIView {
    @IBOutlet weak var passwordTextField: CALightAlphaTextField!
    @IBOutlet weak var usernameTextField: CALightAlphaTextField!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAIPWGSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.usernameTextField.leftView = UIImageView.init(image: UIImage(named: "slide_menu_username"))
//        self.passwordTextField.leftView = UIImageView.init(image: UIImage(named: "slide_menu_password"))
        usernameTextField.leftImage = "slide_menu_username"
        passwordTextField.leftImage = "slide_menu_password"
    }
}
