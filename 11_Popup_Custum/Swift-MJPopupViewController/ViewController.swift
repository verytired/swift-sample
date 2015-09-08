//
//  ViewController.swift
//  Swift-MJPopupViewController
//
//  Created by Yutaka Sano on 2015/09/08.
//  Copyright (c) 2015年 Yutaka Sano. All rights reserved.
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

    @IBAction func onPressButton(){
        //Swift版 MJPopupViewControllerの呼び出し
        let popupView = PopUpViewController(nibName:"PopUpView", bundle:nil)
        presentPopupViewController(popupView, animationType:MJPopupViewAnimationSlideBottomBottom)
    }
}

