//
//  AppDelegate.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import CustomIOSAlertView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var alertView : CustomIOSAlertView!
    var loginAlertView : CALoginAlertView!
    var esusernameTextfield : UITextField!
    var espasswordTextfield : UITextField!
    var esverifycodeTextfield : UITextField!

    var esusername:String!
    var espassword:String!
    var esverigyCode:String!
    var cookie:String!
    
    var window: UIWindow?
    let tabBarController = LCTabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.setupViewControllers()
        if let window = self.window {
//            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
        self.customizeInterface()
        checkCookieisExpired()
        return true
    }
        
    // MARK: - Methods
    private func setupViewControllers() {
        let homeViewController: CAHomeViewController = CAHomeViewController()
        homeViewController.tabBarItem.image = UIImage(named: "home_normal")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "home_selected")
        
        let collectionsViewController: CACollectionsViewController = CACollectionsViewController()
        collectionsViewController.tabBarItem.image = UIImage(named: "collections_normal")
        collectionsViewController.tabBarItem.selectedImage = UIImage(named: "collections_selected")
        
        let profileViewController: CAProfileViewController = CAProfileViewController()
        profileViewController.tabBarItem.image = UIImage(named: "profile_normal")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        let homeNaviController: UINavigationController = CANavigationController.init(rootViewController: homeViewController)
        let collectionNaviController: UINavigationController = CANavigationController.init(rootViewController: collectionsViewController)
        let profileNaviController: UINavigationController = CANavigationController.init(rootViewController: profileViewController)
        self.tabBarController.viewControllers = [homeNaviController, collectionNaviController, profileNaviController]
        
        let slideMenuViewController: CARightSlideMenuViewController = CARightSlideMenuViewController()
        let revealController:SWRevealViewController = SWRevealViewController.init(rearViewController: nil, frontViewController: self.tabBarController)
        revealController.rightViewController = slideMenuViewController
        self.window?.rootViewController = revealController
    }
    
    // 修改NavigationBar和status bar color
    private func customizeInterface() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
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

    // 检测cookie是否可用
    private func checkCookieisExpired() {
        SVProgressHUD.showStatus()
        if CADeanAccountTool.isExistAccountData(){
            let deanAccount = CADeanAccountTool.deanAccount()
            self.esusername = deanAccount.username
            self.espassword = deanAccount.password
            self.cookie = deanAccount.cookie
            CANetworkTool.setAAOCookies(self.cookie)
            
            Alamofire.request(.GET, "http://202.118.31.197/ACTIONLOGON.APPPROCESS?mode=3").validate().responseString {
                (response) in
                switch response.result {
                case .Success:
                    let isCookieExpried = CARegexTool.parseCookieExpried(response.result.value!)
                    if isCookieExpried{ // 过期
                        SVProgressHUD.showErrorMessage("未绑定账户或授权过期，请重新登录！")
                        self.delay(1.5, closure: { 
                            self.displayLoginAlertView()
                        });
                        
                    }else{
                        SVProgressHUD.dismiss()
                    }
                case .Failure(let error):
                    SVProgressHUD.showErrorMessage(kErrorMessage)
                    print(error)
                }
            }
        }else{
            SVProgressHUD.showErrorMessage("未绑定账户或授权过期，请重新登录！")
            self.delay(1.5, closure: {
                self.displayLoginAlertView()
            });
        }

        
    }
    
    func displayLoginAlertView() {
        self.alertView = CustomIOSAlertView.init(parentView: self.window)
        self.loginAlertView = CALoginAlertView.instanceFromNib()
        self.loginAlertView.frame = CGRectMake(0, 0, 290, 203)
        
        self.esusernameTextfield = self.loginAlertView.usernameTextField
        self.espasswordTextfield = self.loginAlertView.passwordTextField
        self.esverifycodeTextfield = self.loginAlertView.verifyCodeTextField
        
        self.loadVerifyCode()
        
        self.loginAlertView.usernameTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.esusername = text
            }
        }
        
        self.loginAlertView.passwordTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
            if let text = next as? String {
                self.espassword = text
            }
        }
        
        self.loginAlertView.verifyCodeTextField.rac_textSignal().subscribeNext {  (next:AnyObject!) -> () in
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
            self.alertView.buttonTitles = ["登录", "解绑"];
        }else{
            self.alertView.buttonTitles = ["登录"];
        }
        
        self.alertView.containerView = self.loginAlertView
        self.alertView.delegate = self
        self.alertView.useMotionEffects = true
        self.alertView.show()
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


extension AppDelegate:CustomIOSAlertViewDelegate{
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
                            let cookieDic = CANetworkTool.getAAOCookies()
                            let cookie = cookieDic?.value
                            CANetworkTool.setAAOCookies(cookie!)
                            let deanAccount = CADeanAccount()
                            deanAccount.username = self.esusername
                            deanAccount.password = self.espassword
                            deanAccount.cookie = cookie
                            CADeanAccountTool.saveAccount(deanAccount)
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
            actionSheet.showInView(self.window!)
            
        }else{
            alertView.close()
        }
    }
}

extension AppDelegate:UIActionSheetDelegate{
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex==0 {
            CADeanAccountTool.removeAccount()
            SVProgressHUD.showSuccessMessage("解绑成功")
            alertView.close()
        }
    }
}


