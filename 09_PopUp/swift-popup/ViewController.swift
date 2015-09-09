//
//  ViewController.swift
//  swift-popup
//
//  Created by Yutaka Sano on 2015/09/07.
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


    //通常
    @IBAction func onTappedAlert(sender: UIButton) {
        println("onPressButton")
        var alert = UIAlertView()
        alert.title = "test"
        alert.message = "保存しました的なメッセージが出ます。"
        alert.addButtonWithTitle("OK")
        alert.show()

    }

    //通常
    @IBAction func onTappedAlertController(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in self.onPressOK()
        }
        
        alertController.addAction(otherAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func onPressOK(){
        println("#onPressOK pushed OK!")
    }
    
    //選択
    @IBAction func choiceBtn(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in println("pushed OK!")
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
            action in println("Pushed CANCEL!")
        }
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    //ボトム表示
    @IBAction func onTappedPopUp(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "First", style: .Default) {
            action in println("Pushed First")
        }
        let secondAction = UIAlertAction(title: "Second", style: .Default) {
            action in println("Pushed Second")
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
            action in println("Pushed CANCEL")
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //For ipad And Univarsal Device
        alertController.popoverPresentationController?.sourceView = sender as UIView;
        alertController.popoverPresentationController?.sourceRect = CGRect(x: (sender.frame.width/2), y: sender.frame.height, width: 0, height: 0)
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //フォーム付
    @IBAction func inputFieldBtn(sender: UIButton) {
        var inputTextField: UITextField?
        var passwordField: UITextField?
        
        let alertController: UIAlertController = UIAlertController(title: "Login", message: "Input your ID and Password", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            println("Pushed CANCEL")
        }
        alertController.addAction(cancelAction)
        
        let logintAction: UIAlertAction = UIAlertAction(title: "Login", style: .Default) { action -> Void in
            println("Pushed Login")
            println(inputTextField?.text)
            println(passwordField?.text)
        }
        alertController.addAction(logintAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.placeholder = "ID"
        }
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            passwordField = textField
            textField.secureTextEntry = true
            textField.placeholder = "password"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    
}

