//
//  ProgressBar.swift
//  Mockup02
//
//  Created by ProgrammingMac on 4/25/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit

class ProgressBar : UIView
{
    
    private var taskName: String?
    var percentage:Double!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetCommonAttributes( )
        let a = frame.width
        let h = frame.height
        print( "ProgressBar - w = \(a) - h = \(h)"  )
    }

    convenience init() {

            self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        
        super.init(coder: aDecoder)
        SetCommonAttributes( )
    }
    

    public func SetCommonAttributes( )->Void
    {
        taskName = "none"
        percentage = 0
        //self.backgroundColor = UIColor.red
        print("Attributes set")
    }
    
    
    public func SetPercentage( _ percent : Double )-> Void {
        percentage = percent
    }
    
        override func draw( _ rect : CGRect)->Void
        {
            super.draw(rect)
            var rectangle: CGRect!
            if( percentage <= 100.0 ) {
                var Size:CGSize = self.frame.size
                //self.layer.contents
                let Origin = self.frame.origin
                Size.width = Size.width  * CGFloat( percentage )
                rectangle = CGRect( origin: Origin, size : Size )
                super.draw( rectangle )
                self.backgroundColor = UIColor.red
//                self.backgroundColor?.setFill()
//                UIGraphicsGetCurrentContext()!.fill(rectangle);
            }
            //print( "draw r.w = \(rectangle.width) - r.h = \(rectangle.height)")
        }
}
