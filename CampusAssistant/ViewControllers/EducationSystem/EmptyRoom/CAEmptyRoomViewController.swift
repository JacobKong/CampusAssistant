//
//  CAEmptyRoomViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAEmptyRoomViewController: UIViewController {
    
    var collectionView:UICollectionView!
    let functionCellIdentifier = "RoomNameCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "空教室"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
//        setupCollectionsArray()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        //间隔
        let spacing:CGFloat = 10
        // 横向按钮间距
        layout.minimumInteritemSpacing = spacing
        
        //垂直行间距
        layout.minimumLineSpacing = spacing
        
        // 列数
        let columnsNum = 4
        
        // 设置itemSize
        let itemSizeW:CGFloat = (kScreenWidth - spacing * CGFloat(columnsNum+1))/CGFloat(columnsNum)
        let itemSizeH:CGFloat = 40
        layout.itemSize = CGSizeMake(itemSizeW, itemSizeH)
        
        // 设置四周间距
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 66), collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(UINib(nibName: "CARoomNameCell", bundle: nil), forCellWithReuseIdentifier: functionCellIdentifier)
//        self.collectionView.registerNib(CACollectionTitleHeader.nib(), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier:collectionSectionHeaderCellIdentifier)
        self.view.addSubview(collectionView)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CAEmptyRoomViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
//        return self.collections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50;
//        let functionsArray = self.collections[section].functions as! [CAFunction]
//        return functionsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(functionCellIdentifier, forIndexPath: indexPath) as! CARoomNameCell
//        let functionsArray = self.collections[indexPath.section].functions as! [CAFunction]
//        let function = functionsArray[indexPath.item]
//        cell.functionIcon.image = UIImage(named: function.icon)
//        cell.functionLabel.text = function.name
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//
//    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        return CGSizeMake(kScreenWidth, 40)
//    }
//    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: collectionSectionHeaderCellIdentifier, forIndexPath: indexPath) as! CACollectionTitleHeader
//        let collection = self.collections[indexPath.section]
//        cell.titleLabel.text = collection.function_name
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath.section, indexPath.item)
//        //        let testVc = CAProfileViewController()
//        //        self.navigationController?.pushViewController(testVc, animated: true)
//    }

}
