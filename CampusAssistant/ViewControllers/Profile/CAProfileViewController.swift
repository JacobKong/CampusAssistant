//
//  CAProfileViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAProfileViewController: UIViewController {
    var tableView:UITableView!
    var profileHeader:CAProfileHeader!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "PROFILE"
        removeNavigationBarBorder()
        setupTableView()
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 66), style: .Plain)
        self.profileHeader = CAProfileHeader.instanceFromNib() as! CAProfileHeader
        self.tableView.backgroundColor = kRGBA(74, g: 144, b: 226, a: 100)
        self.tableView.tableHeaderView = profileHeader
        self.view.addSubview(self.tableView)
    }
    
    private func removeNavigationBarBorder(){
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
    }
    
}

extension CAProfileViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
}
