//
//  ViewController.swift
//  eChef
//
//  Created by ProgrammingMac on 4/17/18.
//  Copyright © 2018 ProgrammingMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var stack: UIStackView!
    override func loadView() {
        stack = UIStackView()
        view = stack;
        //stack.
        stack.axis = .horizontal
//        stack.alignment = .firstBaseline
//        stack.distribution = .fill
        stack.spacing = 8
        
        let label = UILabel(  )
        label.text = "Julien"
        
        let tabBar = UITabBar()
        //let items = [UITabBarItem](){"First Item"; "Second Item"}
        let item1 = UITabBarItem()
        item1.title = "First"
        let item2 = UITabBarItem()
        item2.title = "Second"
        tabBar.items?.append(item1)
        tabBar.items?.append(item2)
        
//        stack.insertArrangedSubview( label, at: 0)
//        stack.insertArrangedSubview( tabBar, at: 1)
//        stack.addArrangedSubview(label)
        stack.addArrangedSubview(tabBar)



    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

