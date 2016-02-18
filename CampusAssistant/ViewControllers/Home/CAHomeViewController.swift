//
//  CAHomeViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAHomeViewController: UIViewController, UIScrollViewDelegate {
    
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
        setupScrollerView()
		setupWeatherSection()
        setupStudyLifeSection()
        setupAddMoreSection()
//        self.title = "NEU CAMPUS ASSISTANT"
//        self.title = "NEU Campus Assistant"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// 设置navigationBar
	private func setupNavigationBar() {
		self.title = "NEU"
		let rightBarBtn = UIButton()
		rightBarBtn.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
		rightBarBtn.setImage(UIImage(named: "navigationbar_side_menu_highlight"), forState: .Highlighted)
		rightBarBtn.frame = CGRectMake(0, 0, 25, 25)
		rightBarBtn.addTarget(self, action: Selector("showRigthSideMenu"), forControlEvents: .TouchUpInside)
		let rightBarButton = UIBarButtonItem()
		rightBarButton.customView = rightBarBtn
		self.navigationItem.rightBarButtonItem = rightBarButton
	}
    private func setupScrollerView(){
        let scrollView = UIScrollView.init(frame: kScreenBounds)
        self.view = scrollView
        scrollView.contentSize = CGSize(width:kScreenWidth, height: kScreenHeight+20)
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
    }
    
	private func setupWeatherSection() {
        let view:UIView = CAWeatherSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 0, kScreenWidth, 220)
		self.view.addSubview(view)
	}
    
    private func setupStudyLifeSection(){
        let view:UIView = CAStudyLifeSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 220, kScreenWidth, 230)
        self.view.addSubview(view)
    }
    
    private func setupAddMoreSection(){
        let view:UIView = CAAddMoreSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 450, kScreenWidth, 50)
        self.view.addSubview(view)
    }
	func showRigthSideMenu() {
		print("clicked")
	}
}
