//
//  ViewController.swift
//  Swift-Twitter
//
//  Created by Yutaka Sano on 2015/09/03.
//  Copyright (c) 2015年 Yutaka Sano. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    var myComposeView : SLComposeViewController!
    var myTwitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Twitter用のUIButtonの生成.
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        // ボタン.
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRectMake(0,0,100,100)
        myTwitterButton.backgroundColor = myColor
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton.layer.cornerRadius = 50.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2-200)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents: .TouchUpInside)
        
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
        
        //facebook
        // Facebookカラーの作成.
        let hex2: Int = 0x3B5998
        let red2 = Double((hex2 & 0xFF0000) >> 16) / 255.0
        let green2 = Double((hex2 & 0xFF00) >> 8) / 255.0
        let blue2 = Double((hex2 & 0xFF)) / 255.0
        var myColor2: UIColor = UIColor( red: CGFloat(red2), green: CGFloat(green2), blue: CGFloat(blue2), alpha: CGFloat(1.0))
        
        // Facebook用のUIButtonの生成.
        var myFacebookButton = UIButton(frame: CGRectMake(0, 0, 100, 100))
        myFacebookButton.backgroundColor = myColor2
        myFacebookButton.setTitle("Facebook", forState: UIControlState.Normal)
        myFacebookButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myFacebookButton.addTarget(self, action: "postToFacebook:", forControlEvents: UIControlEvents.TouchUpInside)
        myFacebookButton.layer.cornerRadius = 50.0
        myFacebookButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        
        // buttonをviewに追加.
        self.view.addSubview(myFacebookButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ボタンイベント.
    func onPostToTwitter(sender : AnyObject) {
        
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("Twitter Test from Swift")
        
        // 投稿する画像を指定.
        myComposeView.addImage(UIImage(named: "oouchi.jpg"))
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    // ボタンイベント.
    func postToFacebook(sender : UIButton) {
        
        // postToTwitterと同様.
        // ServiceTypeをFacebookに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("Facebook Test")
        
        // 投稿する画像を指定.
        myComposeView.addImage(UIImage(named: "sample1.jpg"))
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
}

