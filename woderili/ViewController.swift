//
//  AddressViewController.swift
//  NewGreen
//
//  Created by 恒江 on 2016/7/20.
//  Copyright © 2016年 恒江. All rights reserved.
//

import UIKit

private let identifierCell = "identifier"
private let identifierHead = "identifierHead"

let  maiScr = UIScreen.mainScreen().bounds.size
func RGBA (red:CGFloat, green:CGFloat, blue:CGFloat) ->UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}


class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    private var tempIndexPath = NSIndexPath()
    private var dataSource = NSMutableArray()
    private var tempDate = NSDate()
    
    var closure : ((str: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
        setNacigationItem(NSDate.init())
        
        tempIndexPath = NSIndexPath.init(forItem: 0, inSection: 0)
        
        currentMonthForDataSource(NSDate.init())
        self.view.addSubview(self.collecView)
        
        
        let leftItem = UIBarButtonItem.init(title: "上个月", style: .Done, target: self, action: #selector(ViewController.lastMonth))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem.init(title: "下个月", style: .Done, target: self, action: #selector(ViewController.nextMonth))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func lastMonth() {
        tempDate = tempDate.lastMonth()
        setNacigationItem(tempDate)
        currentMonthForDataSource(tempDate)
        self.collecView.reloadData()
    }
    func nextMonth() {
        tempDate = tempDate.nextMonth()
        setNacigationItem(tempDate)
        currentMonthForDataSource(tempDate)
        self.collecView.reloadData()
    }
    
    func currentMonthForDataSource(date : NSDate) {
        
        tempDate = tempDate.dateForGMT()
        let daysCurrnetMonth = tempDate.numberOfDaysInCurrentMonth()
        let weekLy = tempDate.firstDayOfCurrentMonth().weeklyOrdinality()
        
        dataSource.removeAllObjects()
        if weekLy > 1 {
            for _ in 1...weekLy - 1 {
                dataSource.addObject(" ")
            }
        }
        for i in 1...daysCurrnetMonth {
            
            dataSource.addObject(String.init(i))
        }
        
    }
    
    func setNacigationItem(date : NSDate) {
        
        let formt = NSDateFormatter.init()
        formt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let titleStr = formt.stringFromDate(date)
        self.navigationItem.title = titleStr
    }
    
    lazy var collecView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .Vertical
        let width = ( maiScr.width - 2 * 10 ) / 7
        layout.itemSize = CGSizeMake(width, 50)
        layout.headerReferenceSize = CGSizeMake(maiScr.width - 20, 40)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        var temperaty : UICollectionView = UICollectionView.init(frame: CGRectMake(10, 10 , maiScr.width - 20, 50 * 6 + 40 ), collectionViewLayout: layout)
        temperaty.backgroundColor = UIColor.whiteColor()
        temperaty.delegate = self
        temperaty.dataSource = self
        temperaty.allowsMultipleSelection = false
        temperaty.showsVerticalScrollIndicator = false
        temperaty.scrollEnabled = false
        temperaty.registerClass(headerView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifierHead)
        temperaty.registerClass(collectionViewCell.classForCoder(), forCellWithReuseIdentifier:identifierCell)
        
        return temperaty
    }()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifierCell, forIndexPath: indexPath) as! collectionViewCell
        
        if indexPath.item < self.dataSource.count {
            
//            if dataSource[indexPath.item] as! NSObject == 25 {
//                cell.titl.backgroundColor = UIColor.orangeColor()
//            }
            
            let str = dataSource[indexPath.item] as? String
            
            cell.titl.text = str
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: identifierHead, forIndexPath: indexPath) as! headerView
        
        return view
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //        if (closure != nil) {
        //            closure!(str: (dataSource[indexPath.item] as? String)!)
        //        }
        
        if tempIndexPath != indexPath {
            let tempCell = self.collecView.cellForItemAtIndexPath(tempIndexPath) as! collectionViewCell
            tempCell.titl.backgroundColor = UIColor.whiteColor()
            
            let cell = self.collecView.cellForItemAtIndexPath(indexPath) as! collectionViewCell
            cell.titl.backgroundColor = UIColor.lightGrayColor()
            
            tempIndexPath = indexPath
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NSDate{
    
}

private class headerView : UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let arr = ["一","二","三","四","五","六","日"]
        
        let wid = ( maiScr.width - 20 ) / 7
        
        for i  in 0...6 {
            
            let week = UILabel.init(frame: CGRectMake(wid * CGFloat(i) , 10, wid - 1, 20))
            week.text = arr[i]
            week.textAlignment = .Center
            week.textColor = UIColor.blackColor()
            self.addSubview(week)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class collectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titl)
        
    }
    
    lazy var titl : UILabel = {
        let temperary = UILabel.init(frame: CGRectMake(5, 5, 40, 40))
        temperary.textAlignment = .Center
        //        temperary.translatesAutoresizingMaskIntoConstraints = false
        temperary.font = UIFont.systemFontOfSize(15)
        temperary.backgroundColor = UIColor.clearColor()
        temperary.layer.cornerRadius = 20
        temperary.layer.masksToBounds = true
        return temperary
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


