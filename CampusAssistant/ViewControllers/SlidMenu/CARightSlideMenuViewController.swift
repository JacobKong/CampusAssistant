
//
//  CARightSlideMenuViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/21.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import SCLAlertView
class CARightSlideMenuViewController: UIViewController {
    var scrollView : TPKeyboardAvoidingScrollView!
//    var usernameTextField = CALightAlphaTextField()
//    var passwordTextField = CALightAlphaTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBgImage()
        setupScrollerView()
        setupAccountSection()
        setupIPWGSection()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupScrollerView(){
        self.scrollView = TPKeyboardAvoidingScrollView.init(frame: kScreenBounds)
        self.scrollView.contentSize = CGSize(width:kScreenWidth, height: kScreenHeight)
        self.scrollView.scrollEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
//        self.view.backgroundColor = UIColor.blackColor()
    }
    
    private func setupBgImage(){
        let imageView = UIImageView.init(frame: self.view.frame)
        imageView.image = UIImage(named: "slide_menu_bg")
        self.view.addSubview(imageView)
    }
    
    private func setupAccountSection(){
        let accountSection = CAAccountSectionView.instanceFromNib() as! CAAccountSectionView
        let accountX:CGFloat = 60
        let accountY:CGFloat = 15
        let accountW:CGFloat = kScreenWidth - 60
        let accountH:CGFloat = 190
        accountSection.frame = CGRectMake(accountX, accountY, accountW, accountH)
        accountSection.delegate = self
        self.scrollView.addSubview(accountSection)
    }
    
    private func setupIPWGSection(){
        let IPWGSection = CAIPWGSectionView.instanceFromNib() as! CAIPWGSectionView
        let IPWGX:CGFloat = 60
        let IPWGY:CGFloat = 200
        let IPWGW:CGFloat = kScreenWidth - 60
        let IPWGH:CGFloat = 170
        IPWGSection.frame = CGRectMake(IPWGX, IPWGY, IPWGW, IPWGH)
//        IPWGSection.usernameTextField.delegate = self
//        IPWGSection.passwordTextField.delegate = self
//        self.passwordTextField = IPWGSection.passwordTextField
//        self.usernameTextField = IPWGSection.usernameTextField
        self.scrollView.addSubview(IPWGSection)
    }
}


extension CARightSlideMenuViewController:CAAccountSectionViewDelegate{
    func bindDeanAccountButtonDidCliked() {
        let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
        print("binddean")
    }
    
    func bindLibraryAccountButtonDidCliked(){
        print("bindlibrary")
        
    }
    
    func bindEcardAccountButtonDidCliked(){
        print("bindecard")
        
    }
}
