//
//  AccountController.swift
//  eChefv2.1
//
//  Created by Mitch's MacBook on 4/25/18.
//  Copyright © 2018 Mitchell Rowley. All rights reserved.
//

import UIKit

class AccountController : UIViewController
{
    var gTimer : GraphicTimer?
    var timer : Timer?
    var isRunning: Bool?
    @IBOutlet var container : UIView!
    var percentage:Double!
    

    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        percentage = 0.0
        gTimer = GraphicTimer(coder : NSCoder())

        self.isRunning = true
//        if( isRunning == true )
//        {
//            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(CookbookController.UpdateTimer), userInfo: nil, repeats: true)
//        }
    }
    
    @objc func UpdateTimer()->Void
    {
        percentage = percentage + 0.01
        gTimer?.SetPercentage( percentage )
        container.setNeedsDisplay()
        self.view.setNeedsDisplay()
        
//        yOffset! = yOffset! + scrollSpeed!
//
//        let subviews = self.scrollView.subviews
//        for subview in subviews{
//            subview.removeFromSuperview()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        container.addSubview(gTimer!)
        
    }
}
