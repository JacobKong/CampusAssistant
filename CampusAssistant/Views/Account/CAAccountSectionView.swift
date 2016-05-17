//
//  CAAccountSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

@objc protocol CAAccountSectionViewDelegate{
    func bindDeanAccountButtonDidCliked()
    func bindLibraryAccountButtonDidCliked()
    func bindEcardAccountButtonDidCliked()
}

class CAAccountSectionView: UIView {
    weak var delegate:CAAccountSectionViewDelegate?
    @IBOutlet weak var ecaedBindState: UILabel!
    @IBOutlet weak var libraryBindState: UILabel!
    @IBOutlet weak var deanBindState: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAAccountSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    @IBAction func bindEcardAccountButtonCliked(sender: AnyObject) {
        self.delegate?.bindEcardAccountButtonDidCliked()
    }
    @IBAction func bindLibraryAccountButtonCliked(sender: AnyObject) {
        self.delegate?.bindLibraryAccountButtonDidCliked()
    }
    @IBAction func bindDeanAccountButtonCliked(sender: AnyObject) {
        self.delegate?.bindDeanAccountButtonDidCliked()
    }
    

}
