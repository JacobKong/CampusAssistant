//
//  CAIPWGSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAIPWGSectionView: UIView {
    @IBOutlet weak var disconnect_btn: UIButton!
    @IBOutlet weak var connect_btn: UIButton!
    @IBOutlet weak var passwordTextField: CALightAlphaTextField!
    @IBOutlet weak var usernameTextField: CALightAlphaTextField!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAIPWGSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        usernameTextField.leftImage = "slide_menu_username"
        passwordTextField.leftImage = "slide_menu_password"
        self.passwordTextField.secureTextEntry = true
    self.connect_btn.setBackgroundImage(UIImage.resizeableImageWithName("slide_menu_connect_btn_bg"), forState: UIControlState.Normal)
    }
}
