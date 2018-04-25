//
//  HomeController.swift
//  Mockup02
//
//  Created by Julien Esposito on 4/19/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit


class HomeController : UIViewController
{
    @IBOutlet var mButtonToLastRecipe: UIButton!
    @IBOutlet var mButtonToLastNeutral: UIButton!
    @IBOutlet var mContainerView: UIView!
    
//    var LastRecipe: UIViewController!
//    var Neutral:
    private lazy var LastRecipe: UIViewController =
    {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "LastRecipe")
        return viewController
    }()
    
    private lazy var Neutral: UIViewController =
    {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "Neutral")
        return viewController
    }()
    
    private lazy var Cookbook: CookbookController =
    {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "Cookbook") as! CookbookController
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        mContainerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = mContainerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    override func loadView() {
        super.loadView()
//        self.remove( asChildViewController: LastRecipe )
        add( asChildViewController: Neutral )
    }
    

    @IBAction func ActionLoadLoadLastRecipe(_ sender: UIButton) {
        remove( asChildViewController: Neutral )
        add( asChildViewController: Cookbook )
    }
    
    
    @IBAction func ActionLoadNeutral(_ sender: UIButton) {
        remove(asChildViewController: Cookbook)
        add(asChildViewController: Neutral)
    }

}
