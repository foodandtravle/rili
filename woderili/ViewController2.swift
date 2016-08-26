//
//  ViewController2.swift
//  woderili
//
//  Created by 恒江 on 2016/8/25.
//  Copyright © 2016年 恒江. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        let item = UIBarButtonItem.init(title: "next", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController2.next))
        self.navigationItem.rightBarButtonItem = item
        
        
    
        var currentDate = NSDate.init()
        currentDate = currentDate.lastDayOfCurrentMonth()
        print( currentDate)
        
        
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.init(abbreviation: "CST")!
        
        
        let num = calendar.ordinalityOfUnit(.Day, inUnit: .WeekOfMonth, forDate: currentDate)
        
        
        print( num)

        
        
//        let num = currentDate.weeklyOrdinality()
//        print(num)
        
        
    }
    
    func next() {
        let hvc = ViewController()
        self.navigationController?.pushViewController(hvc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
