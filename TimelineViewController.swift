//
//  TimelineViewController.swift
//  theGram
//
//  Created by macbookair11 on 3/15/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var feeds = [PFObject]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 267
        
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Post.fetchData(nil, completion: {(feeds, error) -> () in
            print("Success 1")
            self.feeds = feeds
            self.tableView.reloadData()
            print(feeds)
 
        })
        self.tableView.reloadData()
        print("bxx")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if feeds != nil {
            return feeds!.count
        } else {
            return 0
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoCell
        
        let feed = feeds![indexPath.row]
        
        cell.feed = feed
        
        return cell
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
