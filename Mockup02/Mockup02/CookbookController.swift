//
//  CookbookController.swift
//  Mockup02
//
//  Created by ProgrammingMac on 4/19/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit

class CookbookController : UIViewController
{
    @IBOutlet var scrollView: UIScrollView!
    var images = [UIImage?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let layoutmargins = self.scrollView.directionalLayoutMargins
        let additionalMargin = CGFloat( 8 )
        
        let scroll_w = scrollView.frame.width
        let scroll_h = scrollView.frame.height
        

        
//        let margins = view.layoutMarginsGuide
//        let topConstraint = segmentedControl.topAnchor.constraint( equalTo: topLayoutGuide.bottomAnchor, constant: 8 )
        let x_left = scrollView.leadingAnchor
        let x_right = layoutmargins.trailing
        
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

            let y = CGFloat( level_y ) * CGFloat( h + 2 * spacing )
            
            imageView.frame = CGRect(x: x, y: y, width: w, height: h)
            imageView.contentMode = .scaleAspectFit
            imageView.image = images[i]
            
            scrollView.contentSize.width = 120
            scrollView.addSubview(imageView)
        }
    }
}
