//
//  CALoginAlertView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/17.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CALoginAlertView: UIView {

    @IBOutlet weak var verifyCodeImageView: UIImageView!
    @IBOutlet weak var verifyCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginTitleLabel: UILabel!
    class func instanceFromNib() -> CALoginAlertView {
        return UINib(nibName: "CALoginAlertView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CALoginAlertView
    }
    
    class func nib() -> UINib{
        return UINib(nibName: "CALoginAlertView", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.loginTitleLabel.textColor = UIColor.caNavigationBarColor()
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
    }
}
