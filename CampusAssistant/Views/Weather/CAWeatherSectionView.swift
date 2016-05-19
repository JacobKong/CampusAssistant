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
    
    func setupTemperature(index:Int, min:Int, max:Int) {
        let temp = "\(max)º ~ \(min)º"
        switch (index){
        case 0:
            firstTempLabel.text = temp
            break;
        case 1:
            secondTempLabel.text = temp
            break;
        case 2:
            thirdTempLabel.text = temp
            break;
        default:
            break;
        }
    }
    
    func setupWeedNoTextview(today:Int){
        setupWeekNo(secondWeekNoLabel, weekNo: today+2)
        setupWeekNo(thirdWeekNoLabel, weekNo: today+3)
    }
    
    func setupWeatherIcon(index:Int, iconName:String){
        let icon_name = "weather_\(iconName)"
        switch (index){
        case 0:
            firstWeatherImage.image = UIImage(named:icon_name)
            break;
        case 1:
            secondWeatherImage.image = UIImage(named:icon_name)
            break;
        case 2:
            thirdWeatherImage.image = UIImage(named:icon_name)
            break;
        default:
            break;
        }
    }
    
    private func setupWeekNo(label:UILabel, weekNo:Int){
        switch (weekNo){
        case 1:
            label.text = "周日"
            break;
        case 2:
            label.text = "周一"
            break;
        case 3:
            label.text = "周二"
            break;
        case 4:
            label.text = "周三"
            break;
        case 5:
            label.text = "周四"
            break;
        case 6:
            label.text = "周五"
            break;
        case 7:
            label.text = "周六"
            break;
        case 8:
            label.text = "周日"
            break;
        case 9:
            label.text = "周一"
            break;
        default:
            break;
        }
    }
}
