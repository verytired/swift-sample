//
//  ViewController.swift
//  Swift-Ad
//
//  Created by Yutaka Sano on 2015/09/08.
//  Copyright (c) 2015年 Yutaka Sano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        //ad
        ImobileSdkAds.registerWithPublisherID("34816", mediaID: "135002", spotID:"342407")
        //ImobileSdkAds.setAdOrientation(IMOBILESDKADS_AD_ORIENTATION_PORTRAIT)
        ImobileSdkAds.startBySpotID("342407")
        //ImobileSdkAds.showBySpotID("342407",viewController:self,position:CGPoint(x:0,y:320),sizeAdjust:true)

        var adView  = UIView(frame: CGRect(x:0,y:320,width:320,height:50))
        self.view.addSubview(adView)
        ImobileSdkAds.showBySpotID("342407",view:adView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

