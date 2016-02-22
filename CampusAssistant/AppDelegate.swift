//
//  AppDelegate.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import LCTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
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
        
        let homeNaviController: UINavigationController = UINavigationController.init(rootViewController: homeViewController)
        let collectionNaviController: UINavigationController = UINavigationController.init(rootViewController: collectionsViewController)
        let profileNaviController: UINavigationController = UINavigationController.init(rootViewController: profileViewController)
        self.tabBarController.viewControllers = [homeNaviController, collectionNaviController, profileNaviController]
        
        let slideMenuViewController: CARightSlideMenuViewController = CARightSlideMenuViewController()
        let revealController:SWRevealViewController = SWRevealViewController.init(rearViewController: slideMenuViewController, frontViewController: self.tabBarController)
        revealController.rightViewController = slideMenuViewController
        self.window?.rootViewController = revealController
    }
    
    // 修改NavigationBar和status bar color
    private func customizeInterface() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let backgroundImage = UIImage.init(named: "navigationbar_background_tall")
        let textAttributes: NSDictionary = [
            NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        navigationBarAppearance.setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)
        navigationBarAppearance.titleTextAttributes = textAttributes as? [String : AnyObject]
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    //    private func moveTabbarWhenSlideMenuReveal(slideNaviController: SlideNavigationController){
    //        NSNotificationCenter.defaultCenter().addObserverForName(SlideNavigationControllerDidClose, object: nil, queue: nil) { (note) -> Void in
    //            let menu = note.userInfo!["menu"]
    //            print("Close", menu)
    //            self.tabBarController.tabBar.frame = CGRectMake(slideNaviController.view.frame.origin.x, self.tabbarY, self.tabbarW, self.tabbarH)
    //        }
    //        NSNotificationCenter.defaultCenter().addObserverForName(SlideNavigationControllerDidOpen, object: nil, queue: nil) { (note) -> Void in
    //            let menu = note.userInfo!["menu"]
    //            print("Open", menu)
    //            print(slideNaviController.view.frame)
    //            self.tabBarController.tabBar.frame = CGRectMake(slideNaviController.view.frame.origin.x, self.tabbarY, self.tabbarW, self.tabbarH)
    //        }
    //        NSNotificationCenter.defaultCenter().addObserverForName(SlideNavigationControllerStartMove, object: nil, queue: nil) { (note) -> Void in
    //            let menu = note.userInfo!["menu"]
    //            print("Move", menu)
    //            print(slideNaviController.view.frame)
    //            self.tabBarController.tabBar.frame = CGRectMake(slideNaviController.view.frame.origin.x, self.tabbarY, self.tabbarW, self.tabbarH)
    //        }
    //        print("------------",SlideNavigationController.sharedInstance().panGestureSideOffset)
    //
    //    }
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

