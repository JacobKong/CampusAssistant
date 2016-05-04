//
//  CAExamCell.swift
//  CampusAssistant
//
//  Created by Encode.X on 16/5/3.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAExamCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAExamCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib{
        return UINib(nibName: "CAExamCell", bundle: nil)
    }
    
}
