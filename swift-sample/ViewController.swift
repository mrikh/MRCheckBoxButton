//
//  ViewController.swift
//  swift-sample
//
//  Created by Mayank Rikh on 21/03/17.
//  Copyright © 2017 Mayank Rikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: MRCheckBoxButton) {
        
        sender.updateSelection(select: !sender.currentlySelected)
    }

}

