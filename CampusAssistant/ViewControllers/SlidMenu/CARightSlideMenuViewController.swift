
//
//  CARightSlideMenuViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/21.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import CustomIOSAlertView
import ReactiveCocoa
import SVProgressHUD
import Alamofire
import Regex

class CARightSlideMenuViewController: UIViewController {
    var accountSection:CAAccountSectionView!
    var studentNoTextField:UITextField!
    var passwordtextField:UITextField!
    var scrollView : TPKeyboardAvoidingScrollView!
    var alertView : CustomIOSAlertView!
    var loginAlertView : CALoginAlertView!
    var esusernameTextfield : UITextField!
    var espasswordTextfield : UITextField!
    var esverifycodeTextfield : UITextField!
    
    var esusername:String!
    var espassword:String!
    var esverigyCode:String!
//    var usernameTextField = CALightAlphaTextField()
//    var passwordTextField = CALightAlphaTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBgImage()
        setupScrollerView()
        setupAccountSection()
        setupIPWGSection()
        if CADeanAccountTool.isExistAccountData(){
            self.accountSection.deanBindState.text = "已绑定"
            self.accountSection.deanBindState.textColor = UIColor.caNavigationBarColor()
        }else{
            self.accountSection.deanBindState.text = "未绑定"
            self.accountSection.deanBindState.textColor = UIColor.whiteColor()
        }
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
        accountSection = CAAccountSectionView.instanceFromNib() as! CAAccountSectionView
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
        alertView = CustomIOSAlertView.init(parentView: self.view.window)
        loginAlertView = CALoginAlertView.instanceFromNib()
        loginAlertView.frame = CGRectMake(0, 0, 290, 203)
        
        self.esusernameTextfield = loginAlertView.usernameTextField
        self.espasswordTextfield = loginAlertView.passwordTextField
        self.esverifycodeTextfield = loginAlertView.verifyCodeTextField
        
        loadVerifyCode()
        
        loginAlertView.usernameTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.esusername = text
            }
        }
        
        loginAlertView.passwordTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.espassword = text
            }
        }
        
        loginAlertView.verifyCodeTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.esverigyCode = text
            }
        }
        
        
        if CADeanAccountTool.isExistAccountData(){
            let deanAccount = CADeanAccountTool.deanAccount()
            self.esusernameTextfield.text = deanAccount.username
            self.espasswordTextfield.text = deanAccount.password
            self.esusername = self.esusernameTextfield.text
            self.espassword = self.espasswordTextfield.text
            self.accountSection.deanBindState.text = "已绑定"
            self.accountSection.deanBindState.textColor = UIColor.caNavigationBarColor()
            alertView.buttonTitles = ["登录", "解绑", "取消"];
        }else{
            alertView.buttonTitles = ["登录", "取消"];
        }

        alertView.containerView = loginAlertView
        alertView.delegate = self
        alertView.useMotionEffects = true
        alertView.show()
        
    }
    
    func bindLibraryAccountButtonDidCliked(){
        print("bindlibrary")
        
    }
    
    func bindEcardAccountButtonDidCliked(){
        print("bindecard")
        
    }
    
    private func loadVerifyCode(){
        // 异步加载验证码
        Alamofire.request(.GET,"http://202.118.31.197/ACTIONVALIDATERANDOMPICTURE.APPPROCESS").responseData { (response) in
            switch response.result {
            case .Success:
                let image = UIImage(data: response.data! as NSData)
                self.loginAlertView.verifyCodeImageView.image = image
                break
            case .Failure(let error):
                print(error)
                SVProgressHUD.showErrorMessage(kErrorMessage)
                break
            }
            
        }
    }
}

extension CARightSlideMenuViewController:CustomIOSAlertViewDelegate{
    func customIOS7dialogButtonTouchUpInside(alertView: AnyObject!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex==0 {
            if esusername.length==0 {
                SVProgressHUD.showErrorMessage("请输入学号")
            }else if espassword.length == 0{
                SVProgressHUD.showErrorMessage("请输入密码")
            }else if esverigyCode.length == 0{
                SVProgressHUD.showErrorMessage("请输入验证码")
            }else{
                
                let paras: [String:AnyObject] = [
                    "WebUserNO": esusername,
                    "Password": espassword,
                    "Agnomen": esverigyCode!
                ]
                
                Alamofire.request(.POST, "http://202.118.31.197/ACTIONLOGON.APPPROCESS?mode=4", parameters: paras).validate().responseString {
                    (response) in
                    switch response.result {
                    case .Success:
                        let loginResult = CARegexTool.parseLogin(response.result.value!)
                        if loginResult=="登陆成功"{
                            SVProgressHUD.showSuccessMessage(loginResult)
                            self.accountSection.deanBindState.text = "已绑定"
                            self.accountSection.deanBindState.textColor = UIColor.caNavigationBarColor()
                            let cookieDic = CANetworkTool.getAAOCookies()
                            let cookie = cookieDic?.value
                            CANetworkTool.setAAOCookies(cookie!)
                            let deanAccount = CADeanAccount()
                            deanAccount.username = self.esusername
                            deanAccount.password = self.espassword
                            deanAccount.cookie = cookie
                            CADeanAccountTool.saveAccount(deanAccount)
                            print(cookie)
                            alertView.close()
                        }else if loginResult == "请输入正确的附加码"{
                            self.loadVerifyCode() // 重新加载图片
                            SVProgressHUD.showErrorMessage(loginResult)
                        }
                        
                    case .Failure(let error):
                        print(error)
                        SVProgressHUD.showErrorMessage(kErrorMessage)
                    }
                }
                
            }
        }else if buttonIndex==1{
            let actionSheet = UIActionSheet.init(title: "您确定取消绑定吗？", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "确定")
            actionSheet.showInView(self.view.window!)
            
        }else{
            alertView.close()
        }
    }
}

extension CARightSlideMenuViewController:UIActionSheetDelegate{
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex==0 {
            CADeanAccountTool.removeAccount()
            SVProgressHUD.showSuccessMessage("解绑成功")
            self.accountSection.deanBindState.text = "未绑定"
            self.accountSection.deanBindState.textColor = UIColor.whiteColor()
            alertView.close()
        }
    }
}
