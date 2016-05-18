//
//  CACollectionsViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import MJExtension
import SVProgressHUD
class CACollectionsViewController: UIViewController {
    var collections = NSMutableArray()
    var collectionView:UICollectionView!
    private let functionCellIdentifier = "FunctionCell"
    private let collectionSectionHeaderCellIdentifier = "CollectionSectionHeaderCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "COLLECTIONS"
        self.view.backgroundColor = UIColor.whiteColor()
//        let backItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem = backItem
        setupCollectionsArray()
        setupCollectionView()
    }
    
    // MARK: - 初始化
    private func setupCollectionsArray(){
        // 告诉系统将operations字典数组转为模型数组
        CACollection.mj_setupObjectClassInArray { () -> [NSObject : AnyObject]! in
            return ["functions" : "CAFunction"]
        }
        
        self.collections = CACollection.mj_objectArrayWithFilename("collections.plist")
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        // 设置itemSize
        let itemSizeW:CGFloat = 60
        let itemSizeH:CGFloat = 60
        layout.itemSize = CGSizeMake(itemSizeW, itemSizeH)
        
        // 设置四周间距
        let paddingY:CGFloat = 7
        let paddingX:CGFloat = (kScreenWidth - 4*itemSizeW)/4
        print(paddingY, paddingX)
//        layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX)
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 10, 15)
        
        // 横向按钮间距
        layout.minimumInteritemSpacing = 15;
        
        //垂直行间距
        layout.minimumLineSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 66), collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(UINib(nibName: "CAFunctionCell", bundle: nil), forCellWithReuseIdentifier: functionCellIdentifier)
        self.collectionView.registerNib(CACollectionTitleHeader.nib(), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier:collectionSectionHeaderCellIdentifier)
        self.view.addSubview(collectionView)

    }
}

// MARK: - UICollectionView
extension CACollectionsViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.collections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let functionsArray = self.collections[section].functions as! [CAFunction]
        return functionsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(functionCellIdentifier, forIndexPath: indexPath) as! CAFunctionCell
        let functionsArray = self.collections[indexPath.section].functions as! [CAFunction]
        let function = functionsArray[indexPath.item]
        cell.functionIcon.image = UIImage(named: function.icon)
        cell.functionLabel.text = function.name
        return cell
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSizeMake(kScreenWidth, 40)
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: collectionSectionHeaderCellIdentifier, forIndexPath: indexPath) as! CACollectionTitleHeader
        let collection = self.collections[indexPath.section]
        cell.titleLabel.text = collection.function_name
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let functionsArray = self.collections[indexPath.section].functions as! [CAFunction]
        let function = functionsArray[indexPath.item]
        let destvc_name = function.destvc_name!
        if (destvc_name.length>0) {
            let className = String.init(format: "CampusAssistant.%@", function.destvc_name)
            let aClass = NSClassFromString(className) as!UIViewController.Type
            let viewController = aClass.init()
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            SVProgressHUD.showErrorMessage("该功能暂未开放！")
        }
        
    }

}