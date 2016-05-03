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
    var menuView: BTNavigationDropdownMenu!
    
    
    private let roomNameCellIdentifier = "RoomNameCell"
    private let emptyRoomHeaderCellIdentifier = "EmptyRoomHeadr"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "空教室"
        self.view.backgroundColor = UIColor.whiteColor()
//        setupCollectionsArray()
        setupCollectionView()
        setupNavigationBarDropDownMenu()
    }

    override func viewWillDisappear(animated: Bool) {
        menuView.animationDuration = 0.1
        menuView.hide()
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
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
        
        
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-66), collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(UINib(nibName: "CARoomNameCell", bundle: nil), forCellWithReuseIdentifier: roomNameCellIdentifier)
        
        self.collectionView.registerNib(CAEmptyRoomHeader.nib(), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier:emptyRoomHeaderCellIdentifier)
        self.view.addSubview(collectionView)
        
    }
    
    private func setupNavigationBarDropDownMenu(){
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks","Most Popular", "Latest", "Trending", "Nearest", "Top Picks", "Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "请选择教学楼", items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.caNavigationBarColor()
        menuView.cellSelectionColor = UIColor.caDarkerNavigationBarColor()
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Montserrat-Regular", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
//            self.selectedCellLabel.text = items[indexPath]
        }
        
        self.navigationItem.titleView = menuView
    }


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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(roomNameCellIdentifier, forIndexPath: indexPath) as! CARoomNameCell
//        let functionsArray = self.collections[indexPath.section].functions as! [CAFunction]
//        let function = functionsArray[indexPath.item]
//        cell.functionIcon.image = UIImage(named: function.icon)
//        cell.functionLabel.text = function.name
        return cell
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSizeMake(kScreenWidth, 40)
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: emptyRoomHeaderCellIdentifier, forIndexPath: indexPath) as! CAEmptyRoomHeader
        return cell
    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }

}
