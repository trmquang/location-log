//
//  LogDetailViewController.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/23/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit

class LogDetailViewController: UITableViewController {
    
    // MARK: - Properties
    var log: Log?
    
    // MARK: - View Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (log?.locationArray.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UINib.init(nibName: "LogDetailTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! LogDetailTableViewCell
        
        cell.latitudeLabel.text = log?.locationArray[indexPath.row].coordinate.latitude.toStringWithFormat(".15")
        cell.longitudeLabel.text = log?.locationArray[indexPath.row].coordinate.longitude.toStringWithFormat(".15")
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveNewLog" {
            let logListTableViewController = segue.destinationViewController as! LogListTableViewController
            logListTableViewController.newLog = log
        }
    }
    
}
