//
//  CAHomeViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Spring

class CAHomeViewController: UIViewController {
    var isOpen = false
    
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
        setupScrollerView()
		setupWeatherSection()
        setupStudyLifeSection()
        setupAddMoreSection()
        setupRevealController()
//        self.title = "NEU CAMPUS ASSISTANT"
//        self.title = "NEU Campus Assistant"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// 设置navigationBar
	private func setupNavigationBar() {
		self.title = "NEU"
		let rightBarBtn = DesignableButton()
		rightBarBtn.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
		rightBarBtn.frame = CGRectMake(0, 0, 22, 22)
        rightBarBtn.addTarget(self.revealViewController(), action: #selector(self.revealViewController().rightRevealToggle), forControlEvents: .TouchUpInside)
		let rightBarButton = UIBarButtonItem()
		rightBarButton.customView = rightBarBtn
        self.revealViewController().delegate = self
        self.navigationItem.rightBarButtonItem = rightBarButton
//        let backItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem = backItem
	}
    
    private func setupScrollerView(){
        let scrollView = UIScrollView.init(frame: kScreenBounds)
        self.view = scrollView
        scrollView.contentSize = CGSize(width:kScreenWidth, height: kScreenHeight+20)
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.whiteColor()
    }
    
	private func setupWeatherSection() {
        let view:UIView = CAWeatherSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 0, kScreenWidth, 220)
		self.view.addSubview(view)
	}
    
    private func setupStudyLifeSection(){
        let view = CAStudyLifeSectionView.instanceFromNib() as! CAStudyLifeSectionView
        view.frame = CGRectMake(0, 220, kScreenWidth, 230)
        self.view.addSubview(view)
        view.delegate = self
    }
    
    private func setupAddMoreSection(){
        let view:UIView = CAAddMoreSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 450, kScreenWidth, 50)
        self.view.addSubview(view)
    }
    
    private func setupRevealController(){
        let revealController:SWRevealViewController = self.revealViewController()
        self.view.addGestureRecognizer(revealController.panGestureRecognizer())
        revealController.rightViewRevealWidth = kScreenWidth - 60
    }
    
}

extension CAHomeViewController:SWRevealViewControllerDelegate{
    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
        let rightBarItemButton = self.navigationItem.rightBarButtonItem?.customView as! DesignableButton
        
        if position == FrontViewPosition.Left{ // 关闭
            rightBarItemButton.animation = "morph"
            rightBarItemButton.curve = "linear"
            rightBarItemButton.duration = 0.5
            rightBarItemButton.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
            print("Left")
        }else if position == FrontViewPosition.LeftSide{// 开启
            rightBarItemButton.animation = "morph"
            rightBarItemButton.curve = "linear"
            rightBarItemButton.duration = 0.5
            rightBarItemButton.setImage(UIImage(named: "navigationbar_cancle"), forState: .Normal)
            print("LeftSide")
        }
        rightBarItemButton.animate()
    }
    
}

extension CAHomeViewController:StudyLifeSectionProtocol{
    func classListButoonDidPressed(){
        let classListVc = CAClassListViewController()
        self.navigationController?.pushViewController(classListVc, animated: true)
    }
    func emptyRoomButtonDidPressed(){
        let emptyRoomVc = CAEmptyRoomViewController()
        self.navigationController?.pushViewController(emptyRoomVc, animated: true)
    }
    func checkGradeButtonDidPressed(){
        let chechGradeVc = CACheckGradesViewController()
        self.navigationController?.pushViewController(chechGradeVc, animated: true)
    }
    func examAgendaButtonDidPressed(){
        let examAgendaVc = CAExamAgendaViewController()
        self.navigationController?.pushViewController(examAgendaVc, animated: true)
    }
}