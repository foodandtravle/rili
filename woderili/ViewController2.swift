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
        
        self.view.backgroundColor = UIColor.whiteColor()
        let item = UIBarButtonItem.init(title: "next", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController2.next))
        self.navigationItem.rightBarButtonItem = item
        
//        var currentDate = NSDate.init()
//        var num = currentDate.weeklyOrdinality()
//        print(currentDate)
//        print(num)
//        
//        currentDate = currentDate.nextHour()
//        num = currentDate.weeklyOrdinality()
//        print(currentDate)
//        print(num)
//        
//        for _ in 1...16 {
//            currentDate = currentDate.nextHour()
//            num = currentDate.weeklyOrdinality()
//            print(currentDate)
//            print(num)
//        }
        
        
        
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