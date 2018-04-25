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
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        taskName = "none"
    }
}
