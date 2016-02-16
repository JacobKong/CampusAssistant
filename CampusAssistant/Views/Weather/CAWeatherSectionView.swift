//
//  CAWeatherSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/15.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAWeatherSectionView: UIView {

	class func instanceFromNib() -> UIView {
		return UINib(nibName: "CAWeatherSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
	}
}
