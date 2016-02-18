//
//  CACollectionsViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import MJExtension
class CACollectionsViewController: UIViewController {
    var collections = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "COLLECTIONS"
//        self.title = "Collections"
        // 告诉系统将operations字典数组转为模型数组
        CACollection.mj_setupObjectClassInArray { () -> [NSObject : AnyObject]! in
            return ["functions" : "CAFunction"]
        }
        
        self.collections = CACollection.mj_objectArrayWithFilename("collections.plist")
    }
    
    private func setupSection1(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
