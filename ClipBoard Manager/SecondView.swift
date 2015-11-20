//
//  SecondView.swift
//  ClipBoard Manager
//
//  Created by Mustafa on 8/17/15.
//  Copyright © 2015 Mustafa. All rights reserved.
//

import Foundation
import UIKit

class SecondView: UIViewController {
    
    var firstViewController = ViewController()
    
    var passData = String()
    
    
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textFiled: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = UIColor.blackColor()
        
        
            
        //UIColor(patternImage:UIImage(named:"background")!)
        
        
        textFiled.text = passData
        
        let count = passData.characters.count
        
        countLabel.text = String(count) + "    " + "Characters"
        
    }
    
    
    @IBAction func upperCase(sender: AnyObject) {
        
      let upperCaseLabel =   textFiled.text?.uppercaseString
        
        textFiled.text = upperCaseLabel
        firstViewController.playSound("tap", ext: "mp3")
    }
    
    
    @IBAction func lowerCase(sender: AnyObject) {
        
      let lowerCaseLabel =   textFiled.text?.lowercaseString
        
        textFiled.text = lowerCaseLabel
        firstViewController.playSound("tap", ext: "mp3")
    }
    
    
    @IBAction func copyToClipBaord(sender: AnyObject) {
        
        firstViewController.copyToPasteboard(textFiled.text!)
        firstViewController.playSound("copy", ext: "mp3")
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        
        let shareContant = textFiled.text!
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [shareContant], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        firstViewController.playSound("tap", ext: "mp3")
    }
   
    
}
