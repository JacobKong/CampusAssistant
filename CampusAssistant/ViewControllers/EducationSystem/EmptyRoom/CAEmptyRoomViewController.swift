//
//  CAEmptyRoomViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CAEmptyRoomViewController: UIViewController {
    
    var collectionView:UICollectionView!
    var menuView: BTNavigationDropdownMenu!
    var buildingList:[[String]] = [["Most Popular"]]
    var classRoomArray: [[String]] = Array()
    var todayNo:Int!
    let todayDate = NSDate()
    var selectedBuildingNo:String!
    
    private let roomNameCellIdentifier = "RoomNameCell"
    private let emptyRoomHeaderCellIdentifier = "EmptyRoomHeadr"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "空教室"
        self.view.backgroundColor = UIColor.whiteColor()
        todayNo = todayDate.dayOfWeek()
//        setupCollectionsArray()
        setupCollectionView()
        setupNavigationBarDropDownMenu()
        setupBuildingList()
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
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "请选择教学楼", items: buildingList)
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
            self.menuView.setMenuTitle(self.buildingList[indexPath][1])
            self.selectedBuildingNo = self.buildingList[indexPath][0]
            let para: [String:AnyObject] = [
                "YearTermNO": "14",                   // todo 以后改为先用GET获取学期列表
                "WeekdayID": "\(self.todayNo)",
                "StartSection":"1",
                "EndSection":"12",
                "STORYNO":self.selectedBuildingNo
            ]

            Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYCLASSROOMNOUSE.APPPROCESS", parameters: para).validate().responseString {
                (response) in
                switch response.result {
                case .Success:
                    var r_result: [[String]] = CARegexTool.parseEptClsrmClsrmList(response.result.value!)
                    self.classRoomArray = r_result
                    self.collectionView.reloadData()
                case .Failure(let error):
                    print(error)
                }

            }

        }
        
        self.navigationItem.titleView = menuView
    }
    
    private func setupBuildingList(){

        Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYCLASSROOMNOUSE.APPPROCESS").validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                let r_result: [[String]] = CARegexTool.parseEptClsrmStoryList(response.result.value!)
                self.buildingList.removeAll()
                self.menuView.tableView.items.removeAll()
                for result in r_result{
                    self.buildingList.append(result)
                    self.menuView.tableView.items.append(result[1])
                }
                self.menuView.tableView.reloadData()
                self.menuView.tableView.tableView(self.menuView.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
            case .Failure(let error):
                SVProgressHUD.showErrorMessage(kErrorMessage)
                print(error)
            }

        }
    }


}

extension CAEmptyRoomViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
//        return self.collections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classRoomArray.count;
//        let functionsArray = self.collections[section].functions as! [CAFunction]
//        return functionsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(roomNameCellIdentifier, forIndexPath: indexPath) as! CARoomNameCell
        cell.nameLabel.text = self.classRoomArray[indexPath.item][1]
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
        let para: [String:AnyObject] = [
            "YearTermNO": "14",                   // todo 以后改为先用GET获取学期列表
            "WeekdayID": "\(todayNo)",
            //                "ResultWeeks" : "1",
            "StartSection":"1",
            "EndSection":"12",
            "STORYNO":self.selectedBuildingNo,
            "ClassroomNO": self.classRoomArray[indexPath.item][0]             // todo 选定教学楼后获取教室列表
        ]

        Alamofire.request(.POST, "http://202.118.31.197/ACTIONQUERYCLASSROOMNOUSE.APPPROCESS", parameters: para).validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                print(response)
//                let r_result: [[String]] = CARegexTool.parseEptClsrmTermList(response.result.value!)
//                print(r_result)
            case .Failure(let error):
                print(error)
            }

        }
    }

}
