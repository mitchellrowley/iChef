//
//  GraphicTimer.swift
//  Mockup02
//
//  Created by ProgrammingMac on 4/24/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit

class GraphicTimer : UIView
{
    private var timer: Timer?
    private var taskName: String?
    var percentage:Double!
    
    required init?(coder aDecoder: NSCoder)
    {
        
        super.init(coder: aDecoder)
        taskName = "none"
        percentage = 0
    }
    
    public func SetPercentage( _ percent : Double )-> Void {
        percentage = percent
    }
    
//    override func draw( _ rect : CGRect)->Void
//    {
//        if( percentage <= 100.0 ) {
//            var Size:CGSize = self.frame.size
//            let Origin = self.frame.origin
//            Size.width = Size.width  * CGFloat( percentage )
//            let rectangle = CGRect( origin: Origin, size : Size )
//            self.draw( rectangle )
//            
//        }
//    }
}
