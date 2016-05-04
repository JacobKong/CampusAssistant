//
//  CARoomNameCell.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/4/28.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CARoomNameCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CARoomNameCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
