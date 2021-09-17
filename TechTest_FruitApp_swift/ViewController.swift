//
//  ViewController.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 14/9/2021.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    
    //Auto size Layout for the SwiftUI View
    @IBOutlet weak var listViewContainer: UIView!
    var contentView : FrultList!
    
    //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CommonUtility.instance().setTimemark();
        
        self.contentView = FrultList.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(animated){
            if(CommonUtility.instance().getIsTimeCounting()){
                ConnectionUtility.instance().submitAppUsageState(event: .display, data: "\(CommonUtility.instance().getTimediff())")
            }
            
            //Add to rootView and Update frame size for SwiftUI
            if self.contentView != nil {
                let swiftLayout = UIHostingController(rootView: self.contentView)
                swiftLayout.view.frame = CGRect(origin: CGPoint.zero, size: self.listViewContainer.frame.size)
                self.listViewContainer.addSubview(swiftLayout.view);
                self.listViewContainer.isHidden = false
            }
        }
    }
    
}

