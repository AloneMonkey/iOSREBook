//
//  ViewController.swift
//  SwiftDemo
//
//  Created by monkey on 2017/10/17.
//  Copyright © 2017年 Coder. All rights reserved.
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

    @IBAction func onClick(_ sender: UIButton) {
        let result = self.CustomMethod(number: 10)
        print("origin: \(result)")
    }
    
    func CustomMethod(number: Int) -> Int{
        return number + 10
    }
}

