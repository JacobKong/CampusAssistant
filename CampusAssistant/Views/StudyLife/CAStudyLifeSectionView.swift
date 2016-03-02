//
//  CAStudyLifeSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/16.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

@objc protocol StudyLifeSectionProtocol{
    func classListButoonDidPressed()
    func emptyRoomButtonDidPressed()
    func checkGradeButtonDidPressed()
    func examAgendaButtonDidPressed()
}

class CAStudyLifeSectionView: UIView {
    var delegate:StudyLifeSectionProtocol?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAStudyLifeSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

    @IBAction func classListButtonDidClicked(sender: AnyObject) {
        self.delegate?.classListButoonDidPressed()
    }
    @IBAction func emptyRoomButtonDidClicked(sender: AnyObject) {
        self.delegate?.emptyRoomButtonDidPressed()
    }

    @IBAction func checkGradeButtonDidClicked(sender: AnyObject) {
        self.delegate?.checkGradeButtonDidPressed()
    }
    
    @IBAction func examAgendaButtonDidClicked(sender: AnyObject) {
        self.delegate?.examAgendaButtonDidPressed()
    }
}
