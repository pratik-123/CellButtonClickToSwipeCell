//
//  ViewController.swift
//  TableViewCellButtonSwipeExample
//
//  Created by Dev on 06/11/15.
//  Copyright © 2015 pratik. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var imgFlage:[String] = ["india.png","china.png","japan.png","nepal.png","skorea.png"]
    
    var lblContryName:[String] = ["India","China","Japan","Nepal","Skorea"]
    
    var CustomView:UIView = UIView()
    var boolSwipeCell = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblContryName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let blnName = cell.contentView.viewWithTag(1) as! UILabel
        blnName.text = lblContryName[indexPath.row]
        
        return cell
    }
    
    
    // swipe butto click on cell
    @IBAction func btnOpenSwipe(sender: AnyObject) {
        
        // check is cell is already open then close
        if boolSwipeCell == false
        {
            boolSwipeCell = true
            var rotatFromRightToLeft: CGRect = CustomView.frame
            rotatFromRightToLeft.origin.x = 320
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {    self.CustomView.frame = rotatFromRightToLeft
                }, completion: {(finished: Bool) in
            })
        }
        
        // open cell swipe with content
        if boolSwipeCell == true
        {
            boolSwipeCell = false
            let btnPos: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
            let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(btnPos)!
            
            let tableViewCellRect:CGRect = tableView.convertRect(tableView.rectForRowAtIndexPath(indexPath), fromView: tableView.superview)
            // tableview and view size decrease
            let bound:CGRect = tableView.bounds
            let width = bound.size.width
            var tY = tableViewCellRect.origin.y + 214//218//cell.contentView.bounds.origin.y
            let frame: CGRect = tableView.rectForRowAtIndexPath(indexPath)
            let yOffset: CGPoint = self.tableView.contentOffset
            
            
            //var CustomView: UIView
            // CustomView = UIView(frame: CGRectMake(320, (frame.origin.y + 109 - yOffset.y), width, 84)) // this is used for gap between record
            CustomView = UIView(frame: CGRectMake(320, (frame.origin.y - yOffset.y), width, 89))
            
            CustomView.backgroundColor = UIColor(red:228/255.0, green:228/255.0 ,blue:228/255.0 ,alpha:1.0)
            
            let btnCloseSwipe = UIButton(frame: CGRectMake(0, 26, 30 , 30));
            btnCloseSwipe.backgroundColor = UIColor.grayColor()
            btnCloseSwipe.setTitle(">", forState: .Normal)
            btnCloseSwipe.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btnCloseSwipe.addTarget(self, action: "btnCloseSwipe:", forControlEvents: .TouchUpInside);
            CustomView.addSubview(btnCloseSwipe)
            
            
            // create custom view image and Lable
            let image =  UIImage(named: imgFlage[indexPath.row])
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 40, y: 30, width: 20, height: 20)
            CustomView.addSubview(imageView)
            
            let lblPWR = UILabel(frame: CGRectMake(90, 30, 20, 20))
            lblPWR.text = "\(lblContryName[indexPath.row])"
            lblPWR.textAlignment = NSTextAlignment.Center
            lblPWR.sizeToFit()
            CustomView.addSubview(lblPWR)
            
            
            
            
            var rotatFromRightToLeft: CGRect = CustomView.frame
            rotatFromRightToLeft.origin.x = 0
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {    self.CustomView.frame = rotatFromRightToLeft
                }, completion: {(finished: Bool) in
            })
            
            view.addSubview(CustomView)
        }
    }
    
    // close swipe cell
    func btnCloseSwipe(sender:UIButton)
    {
        boolSwipeCell = true
        var rotatFromRightToLeft: CGRect = CustomView.frame
        rotatFromRightToLeft.origin.x = 320
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {    self.CustomView.frame = rotatFromRightToLeft
            }, completion: {(finished: Bool) in
        })
    }
    
    // when scrolling start at that close open swipe cell
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        if boolSwipeCell == false
        {
            boolSwipeCell = true
            var rotatFromRightToLeft: CGRect = CustomView.frame
            rotatFromRightToLeft.origin.x = 320
            UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {    self.CustomView.frame = rotatFromRightToLeft
                }, completion: {(finished: Bool) in
            })
        }
    }
    
}

