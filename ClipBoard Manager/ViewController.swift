//
//  ViewController.swift
//  ClipBoard Manager
//
//  Created by Mustafa on 8/14/15.
//  Copyright © 2015 Mustafa. All rights reserved.
//

import UIKit
import AVFoundation




class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    //difine arry of strings
    var clipBard = [String]()
    
    var backgroundMusicPlayer:AVAudioPlayer = AVAudioPlayer()
    
    //make a vraible to use pull to refresh
    var refreshControl:UIRefreshControl!
    
    
    //define a varible to the sting in the clipboard
    var pasteBoard = UIPasteboard.generalPasteboard().string
    
    
    
   
    
    
    @IBOutlet weak var clipboardButton: UIButton!
    
    @IBOutlet weak var clipBoardTabel: UITableView!
        
    
    @IBOutlet weak var clipBoardLabel: UILabel!
    
    let sharedData = NSUserDefaults(suiteName: "group.MostafaSoftware.ShareData")
    
    var shareDataToArrayOfStrings = [String]()
    
    
    @IBAction func addToTabel(sender: UIButton) {
        
        
        // add items to the arry
       //cheak if the clipboard Empty
        if clipBoardLabel.text != "SAVED" {
        clipBard.append(clipBoardLabel.text!)
        clipBoardLabel.text = "Saved".uppercaseString
        clipBoardTabel.reloadData()
    //    NSUserDefaults.standardUserDefaults().setObject(clipBard, forKey: "newData")
     //       NSUserDefaults.standardUserDefaults().synchronize()
           playSound("add", ext: "aif")
            
            sharedData?.setObject(clipBard, forKey: "sshareData")
            sharedData?.synchronize()
            
            
            
            /*________________remove label________________
            
            if self.clipBoardLabel.text == "" {
            
            self.clipBoardLabel.hidden = true
            }
            else{
            self.clipBoardLabel.hidden = false
            }
            ______________________________________________*/
        }
        
        
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        // remove tabile view separator
        self.clipBoardTabel.separatorColor = UIColor.clearColor()
        
        // i think make the program faster :(
      //  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) ){
     //       self.updateLabel()
     //   }

        getSharedData()
        
        // when the app load make the label equl to the text in the clipboard
        
        clipBoardLabel.text = getPasteboardContents()
        
        //cheak if the stored data has any value if have vlue it will load it
     //   if NSUserDefaults.standardUserDefaults().objectForKey("newData") != nil {
       
     //   clipBard = NSUserDefaults.standardUserDefaults().objectForKey("newData") as! [String]
            
           
       // }
        
     /*
        if sharedData?.objectForKey("sshareData") != nil
        {
             shareDataToArrayOfStrings = sharedData?.objectForKey("sshareData") as! NSArray as! [String]
            
            clipBard = shareDataToArrayOfStrings
            
            sharedData?.synchronize()
        }
     */
        
        //this one make a certen function work when the app come from background #1
       NSNotificationCenter.defaultCenter().addObserver(self, selector:"updateLabel", name:UIApplicationWillEnterForegroundNotification, object: nil)
        
        
        
        //change the height and the background of the tabel
        self.clipBoardTabel.rowHeight = UITableViewAutomaticDimension
        self.clipBoardTabel.estimatedRowHeight = 44.0
        
       self.clipBoardTabel.backgroundView = UIImageView(image:UIImage(named: "background"))
        
        
        
        //______________________________implimanting pull to refresh__________________//
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.clipBoardTabel.addSubview(refreshControl)
        //___________________________________________end_____________________________//
        
        }

   
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
    //make how many rows in the tabel and now its return the value of the index in the arry
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return clipBard.count
    }
    
    
    
    
    
    
    //make the cell equl to the index vlaue of the arry
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
      {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = clipBard[clipBard.count - 1 - indexPath.row]
        
        //put an image to the right side of the cell
        let myImage = UIImage(named: "cellicon")
        cell.imageView?.image = myImage
        
        //change the text color in the cell
        //cell.textLabel?.textColor = UIColor.blackColor()
        
        //make the first cell and the secound cell has defrenet color
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.clearColor()
          //  cell.textLabel?.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0)
          //  cell.textLabel?.textColor = UIColor.blackColor()
        }
        else
        {
         cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        
        
        return cell
    

    }
    
    
    
    
    
    
    //this funtion update the labels when the app come from background #2
    func updateLabel() {
        
        pasteBoard = getPasteboardContents()
        
       // dispatch_async(dispatch_get_main_queue()){
        
            self.clipBoardLabel.text = "تم الخزن"
        self.clipBoardLabel.text = self.pasteBoard
            
            print(self.getPasteboardContents())
       
           getSharedData()
        self.clipBoardTabel.reloadData()
         
            
            
            /*________________remove label________________/
            
            if self.clipBoardLabel.text == "" {
                
                self.clipBoardLabel.hidden = true
            }
            else{
                self.clipBoardLabel.hidden = false
            }
           /______________________________________________*/
            
      //  }
        

        
    }

    
    
    
    
    
    //this function edit the cell in this its delete the cell and the index of the arry
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            clipBard.removeAtIndex(clipBard.count - 1 - indexPath.row)
            
         //   NSUserDefaults.standardUserDefaults().setObject(clipBard, forKey: "newData")
           
            sharedData?.setObject(clipBard, forKey: "sshareData")
            
            //this reload the tabel when delete item
            clipBoardTabel.reloadData()
            
        }
        playSound("delete", ext: "mp3")
    }
   
    
    
    
    
    // this function get the pasteboard and make equl to the pasteboard varible
    func getPasteboardContents() -> String? {
        
        let pasteboard = UIPasteboard.generalPasteboard()
        return pasteboard.string
    }
    
    
    
    
    
    //this function copy a string to the clipboard
    
    func copyToPasteboard(text: String) {
        
        
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = text
        
    }
    
    
    
    
/*-----------------------------------------old function--------------------------/
    copy the text in the cell to the clipboard when the cell touched
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let cell = clipBoardTabel.cellForRowAtIndexPath(indexPath)
        
            copyToPasteboard((cell!.textLabel?.text)!)
            updateLabel()
            playSound("copy", ext: "mp3")
        let alert:UIAlertView = UIAlertView(title: "Coped", message: cell!.textLabel?.text, delegate: self, cancelButtonTitle: "OK!")
        alert.show()
        
    }
/-------------------------------------------old Function------------------------*/
    
    // funtion to refresh the tabel view which is used in the pull to refresh in view did load methud
 
    
    
    
    
    
    
    func refresh(sender:AnyObject)
    {
        clipBoardTabel.reloadData()
        updateLabel()
        self.refreshControl.endRefreshing()
        playSound("pulltorefresh", ext: "mp3")
        
    }
    
    
    
    //funtion to play sound by give it the name of the file and the type
    
    func playSound(name:String, ext:String) {
        
       let soundPath:NSURL = NSBundle.mainBundle().URLForResource(name, withExtension: ext)!
        
        backgroundMusicPlayer = try!  AVAudioPlayer(contentsOfURL: soundPath)
        
        backgroundMusicPlayer.numberOfLoops = 0
        
        backgroundMusicPlayer.prepareToPlay()
        
        backgroundMusicPlayer.play()
        
    }
    
    //move from the first view to the second view and pass the Data with it Finally :)
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "segue"{
        let path :NSIndexPath = clipBoardTabel.indexPathForSelectedRow!
        
        let destViewController = segue.destinationViewController as! SecondView
        
       
         let text  = clipBoardTabel.cellForRowAtIndexPath(path)
        
        destViewController.passData = (text?.textLabel?.text)!
        
        playSound("slide", ext: "mp3")
        }
    }
    
    func getSharedData () {
        if sharedData?.objectForKey("sshareData") != nil
        {
            shareDataToArrayOfStrings = sharedData?.objectForKey("sshareData") as! NSArray as! [String]
            
            clipBard = shareDataToArrayOfStrings
            
            sharedData?.synchronize()
        }

    }
   /*__________________make colors like clear app_____________
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = clipBard.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
   __________________________________________________________ */
    
   

}


