//
//  ViewController.swift
//  CognitiveVRT
//
//  Created by Oliver Nielsen on 01/12/15.
//  Copyright © 2015 Oliver Nielsen. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
    }
}

