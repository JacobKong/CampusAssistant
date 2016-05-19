//
//  CAWeatherSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/15.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAWeatherSectionView: UIView {

    @IBOutlet weak var thirdWeatherImage: UIImageView!
    @IBOutlet weak var thirdWeekNoLabel: UILabel!
    @IBOutlet weak var thirdTempLabel: UILabel!
    
    @IBOutlet weak var secondWeatherImage: UIImageView!
    @IBOutlet weak var secondWeekNoLabel: UILabel!
    @IBOutlet weak var secondTempLabel: UILabel!
    
    @IBOutlet weak var firstWeatherImage: UIImageView!
    @IBOutlet weak var firstWeekNoLabel: UILabel!
    @IBOutlet weak var firstTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
	class func instanceFromNib() -> UIView {
		return UINib(nibName: "CAWeatherSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
	}
}
