//
//  CookbookController.swift
//  Mockup02
//
//  Created by ProgrammingMac on 4/19/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox

class CookbookController : UIViewController
{
    @IBOutlet var scrollView: UIScrollView!
    var images = [UIImage?]()
    var timer: Timer?
    var isRunning: Bool?
    var yOffset: Int?
    var scrollSpeed: Int?

        
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.timer = Timer()
        yOffset = 0
        scrollSpeed = 2
        
        images = [
            UIImage( named: "A" ),
            UIImage( named: "B" ),
            UIImage( named: "C" ),
            UIImage( named: "D" ),
            UIImage( named: "E" ),
            UIImage( named: "F" ),
            UIImage( named: "G" ),
            UIImage( named: "H" ),
            UIImage( named: "I" )
        ]
        
        self.isRunning = true
        if( isRunning == true ) {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(CookbookController.UpdateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func UpdateTimer()->Void
    {
        yOffset! = yOffset! + scrollSpeed!
        
        let subviews = self.scrollView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        
//        let nSubViews: Int = scrollView.subviews.count
//        if( nSubViews > 0 ) {
//            for i in 0..<nSubViews {
//                let v = scrollView.subviews[ i ]
////                scrollView.bringSubview(toFront: v )
////                v.removeFromSuperview()
//            }
//        }
        let scroll_w = scrollView.frame.width
        var level_y: Int = 0
        for i in 0..<images.count {
            let w = (images[ i ]?.size.width)! * 2
            let h = (images[ i ]?.size.height)! * 2
            let spacing = ( CGFloat( scroll_w ) - CGFloat( 2 * w ) ) / CGFloat( 4.0 )
            let imageView = UIImageView()
            var x = CGFloat(0.0)
            if( i % 2 != 0 ) {
                x = CGFloat( 0.0 ) + spacing
            } else {
                level_y = i / 2
                x = 3 * spacing + w
            }
            
            let y = CGFloat( level_y ) * CGFloat( h + 2 * spacing ) - CGFloat( yOffset! )
            
            imageView.frame = CGRect(x: x, y: y, width: w, height: h)
            imageView.contentMode = .scaleAspectFit
            imageView.image = images[i]
            
            scrollView.contentSize.width = 120
            scrollView.addSubview(imageView)
        }
        
        scrollView.setNeedsDisplay()
        self.view.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        



    }
}
