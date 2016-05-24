
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
    
    var usernameTextField = CALightAlphaTextField()
    var passwordTextField = CALightAlphaTextField()
    var ipgwusername:String!
    var ipgwpassword:String!
    let ipgwunKey = "ipgwusername"
    let ipgwpwdKey = "ipgwpassword"
    
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
        self.passwordTextField = IPWGSection.passwordTextField
        self.usernameTextField = IPWGSection.usernameTextField
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let ipgwusernameKey = userDefault.objectForKey(ipgwunKey)
        let ipgwpasswordKey = userDefault.objectForKey(ipgwpwdKey)
        
//        ipgwusername = ipgwusernameKey as?String
//        ipgwpassword = ipgwpasswordKey as? String
        self.usernameTextField.text = ipgwusernameKey as?String
        self.passwordTextField.text = ipgwpasswordKey as?String
//        if  ipgwusernameKey==nil || ipgwpasswordKey == nil{
//            
//        }else{
//            ipgwusername = ipgwusernameKey as!String
//            ipgwpassword = ipgwpasswordKey as! String
//            self.usernameTextField.text = ipgwusernameKey as?String
//            self.passwordTextField.text = ipgwpasswordKey as?String
//        }
//        
        
        IPWGSection.usernameTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.ipgwusername = text
            }
        }
        
        IPWGSection.passwordTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.ipgwpassword = text
            }
        }

        IPWGSection.connect_btn.addTarget(self, action: #selector(self.connect_btn_cliked), forControlEvents: .TouchUpInside)
        IPWGSection.disconnect_btn.addTarget(self, action: #selector(self.disconnect_btn_clicked), forControlEvents: .TouchUpInside)
        
        self.scrollView.addSubview(IPWGSection)
    }
    
    @objc private func connect_btn_cliked(){
        if self.ipgwusername.length==0 {
            SVProgressHUD.showErrorMessage("请输入校园网账号")
        }else if self.ipgwpassword.length == 0{
            SVProgressHUD.showErrorMessage("请输入账号密码")
        }else{
            SVProgressHUD.showStatus()
            Alamofire.request(.GET, "http://ipgw.neu.edu.cn/ac_detect.php?ac_id=1&").responseString {
                (response) in
                switch response.result {
                case .Success:
//                    print(response.response)
//                    print(response.result.value as String!)
//                    print(response.response?.URL)              // 此项需要首先获取以获得正确请求地址
                    
                    // 登录
                    let par: [String:AnyObject] = [
                        "action":"login",
                        "ac_id":"1",
                        "user_ip":"",
                        "nas_ip":"",
                        "user_mac":"",
                        "url":"",
                        "username":self.ipgwusername,                  // 学号
                        "password":self.ipgwpassword,                    // 密码 此两项需要保存
                        "save_me":"0"
                    ]
                    
                    let url = response.response?.URL?.absoluteString
                    
                    Alamofire.request(.POST, url!, parameters: par).validate().responseString {
                        (response) in
                        switch response.result {
                        case .Success:
                            if CARegexTool.parseIPGWConnect(response.result.value as String!){
                                let userDefault = NSUserDefaults.standardUserDefaults()
                                userDefault.setObject(self.ipgwusername, forKey: self.ipgwunKey)
                                userDefault.setObject(self.ipgwpassword, forKey: self.ipgwpwdKey)
                                userDefault.synchronize()
                                SVProgressHUD.showSuccessMessage("网络已连接")
                            }else{
                                // 来取出错误原因
                                let errorMessage = CARegexTool.parseGateWayErrorResult(response.result.value!)
                                SVProgressHUD.showErrorMessage(errorMessage)
                            }
                        case .Failure(let error):
                            SVProgressHUD.showErrorMessage(kErrorMessage)
                            print(error)
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                }
                
            }
        }
    }
    
    @objc private func disconnect_btn_clicked(){
        if self.ipgwusername.length==0 {
            SVProgressHUD.showErrorMessage("请输入校园网账号")
        }else if self.ipgwpassword.length == 0{
            SVProgressHUD.showErrorMessage("请输入账号密码")
        }else{
            SVProgressHUD.showStatus()
            Alamofire.request(.GET, "http://ipgw.neu.edu.cn/ac_detect.php?ac_id=1&").responseString {
                (response) in
                switch response.result {
                case .Success:
                    // 此项需要首先获取以获得正确请求地址
                    let url = response.response?.URL?.absoluteString
                    let para: [String:AnyObject] = [
                        "action":"auto_logout",
                        "info":"",
                        "user_ip":""                    // 在此处填入ip
                    ]
                    
                    Alamofire.request(.POST, url!, parameters: para).validate().responseString {
                        (response) in
                        switch response.result {
                        case .Success:
                            SVProgressHUD.showSuccessMessage("网络已断开")
                        case .Failure(let error):
                            // 来取出错误原因
                            let errorMessage = CARegexTool.parseGateWayErrorResult(response.result.value!)
                            SVProgressHUD.showErrorMessage(errorMessage)
                            print(error)
                        }
                    }
                case .Failure(let error):
                    SVProgressHUD.showErrorMessage(kErrorMessage)
                    print(error)
                }
            }
            
        }
        
        
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
            SVProgressHUD.showStatus()
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
