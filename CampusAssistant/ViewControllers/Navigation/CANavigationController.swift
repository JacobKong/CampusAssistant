//
//  CANavigationController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CANavigationController: UINavigationController {
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setupNavBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    private func setupNavBar(){
        let navigationBarAppearance = UINavigationBar.appearance()
        let backgroundImage = UIImage.init(named: "navigationbar_background_tall")
        let textAttributes: NSDictionary = [
            NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 19)!, NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        navigationBarAppearance.setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)
        navigationBarAppearance.titleTextAttributes = textAttributes as? [String : AnyObject]
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        navigationBarAppearance.backIndicatorImage = UIImage(named: "navigationbar_back_indicator")
        
        let buttonItem = UIBarButtonItem.appearance()
        let itemTextAttributes: NSDictionary = [
            NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 15)!, NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSForegroundColorAttributeName:UIColor.whiteColor()
        ]
        buttonItem.setTitleTextAttributes(itemTextAttributes as? [String : AnyObject], forState: .Normal)
        buttonItem.setTitleTextAttributes(itemTextAttributes as? [String : AnyObject], forState: .Highlighted)
//        buttonItem.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -100), forBarMetrics: .Default)
    }
}
