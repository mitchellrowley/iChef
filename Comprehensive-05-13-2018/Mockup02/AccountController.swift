//
//  AccountController.swift
//  Mockup02
//
//  Created by ProgrammingMac on 4/25/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit

class AccountController : UIViewController
{
    @IBOutlet var container: UIView!
    private var timer: Timer?
     var progressBar: ProgressBar!
    var progressView1: UIProgressView!
    var percentage: Double!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init( coder: aDecoder)
        self.timer = Timer()
        percentage = 0
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(AccountController.UpdateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTimer()->Void {
        percentage = percentage + 0.01
        progressView1.progress = Float( percentage)
        //progressBar.SetPercentage( percentage )
        //container.setNeedsDisplay()
        //progressBar.setNeedsDisplay()
        //self.view.setNeedsDisplay()
        //print( "Update" )
    }

    override func loadView() {
        super.loadView()
        //progressBar = ProgressBar( frame : container.frame )
        var r = container.frame
        let origin = container.frame.origin
        var sz = container.frame.size
        sz.height = 30
        
        progressView1 = UIProgressView( frame : CGRect( origin: origin, size: sz) )
       // progressView1.frame.height = 25.0
        //progressBar.SetPercentage(100.0)
        container.addSubview( progressView1 )

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        container.setNeedsDisplay()
//        progressBar.setNeedsDisplay()
        //self.v
        //self.view.backgroundColor = UIColor.blue
    }
}
