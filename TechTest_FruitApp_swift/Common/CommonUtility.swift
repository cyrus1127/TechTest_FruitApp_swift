//
//  CommonUtility.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 14/9/2021.
//

import UIKit

class CommonUtility: NSObject {

    static var myIntance : CommonUtility!
    static func instance () -> CommonUtility {
        if ((myIntance as CommonUtility?) == nil) {
            myIntance = CommonUtility.init();
        }
        return myIntance
    }
    
    private var timemark : Double!
    private var timeisCounting = false
    
    func getIsTimeCounting ()->Bool{
        return timeisCounting
    }
    
    func setTimemark (){
        if !timeisCounting {
            timemark = NSDate.now.timeIntervalSince1970
            timeisCounting = true
        }
    }
    
    func getTimediff ()->Int64{
        // get diff of the MS
        let diff = NSNumber.init(value: ((NSDate.now.timeIntervalSince1970 - timemark) * 1000)).int64Value
        
        // do reset
        timemark = -1
        timeisCounting = false
        
        return diff
    }
}
