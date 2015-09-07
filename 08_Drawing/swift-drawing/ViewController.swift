//
//  ViewController.swift
//  swift-drawing
//
//  Created by Yutaka Sano on 2015/09/07.
//  Copyright (c) 2015年 Yutaka Sano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var drawViewArea: drawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func claerTapped(sender: UIButton) {
        var theDrawView : drawView = drawViewArea as drawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
}