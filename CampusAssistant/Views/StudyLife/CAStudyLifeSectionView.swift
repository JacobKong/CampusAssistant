//
//  CAStudyLifeSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/16.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAStudyLifeSectionView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAStudyLifeSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

    @IBAction func classListButtonDidClicked(sender: AnyObject) {
    }
    @IBAction func emptyRoomButtonDidClicked(sender: AnyObject) {
    }

    @IBAction func checkGradeButtonDidClicked(sender: AnyObject) {
    }
    @IBAction func examAgendaButtonDidClicked(sender: AnyObject) {
    }
}
