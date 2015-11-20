//
//  ShareViewController.swift
//  ClipsyShare
//
//  Created by Mustafa on 8/19/15.
//  Copyright © 2015 Mustafa. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    
    
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        
        let savedData = NSUserDefaults(suiteName: "group.MostafaSoftware.ShareData")
       // let currentData = NSUserDefaults.standardUserDefaults()
        
        var savedArray = savedData?.objectForKey("sshareData") as! NSArray as! [String]
        var currentArray = [String]()
        currentArray.append(contentText)
        
        savedArray.appendContentsOf(currentArray)
        
        savedData?.setObject(savedArray, forKey: "sshareData")
        
        savedData?.synchronize()
        
        
        
        
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
