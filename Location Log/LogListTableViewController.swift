//
//  LogListTableViewController.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/23/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class LogListTableViewController: UITableViewController {

    var newLog: Log?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use core data to load the log list
        if appDelegate.loadedLog == false {
            loadLogsFromCoreData()
            appDelegate.loadedLog = true
        }
        // add new log
        if self.newLog != nil {
            appDelegate.logList.append(newLog!)
            addLogToCoreData(newLog!)
            newLog = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.logList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LogTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LogTableViewCell
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.nameLbl.text = appDelegate.logList[indexPath.row].name
        cell.dateLbl.text = dateFormatter.stringFromDate(appDelegate.logList[indexPath.row].date)
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let logDetailNavigationController = segue.destinationViewController as! LogDetailNavigationController
            
            // Get the cell that generated this segue.
            if let selectedLogCell = sender as? LogTableViewCell {
                let selectedIndexPath = tableView.indexPathForCell(selectedLogCell)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let logDetailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LogDetailViewController") as! LogDetailViewController
                let selectedLog = appDelegate.logList[selectedIndexPath!.row]
                logDetailViewController.log = selectedLog
                logDetailNavigationController.pushViewController(logDetailViewController, animated: true)
            }
        }
    }
    

    @IBAction func cancelBtn_Tapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Methods
    /** Load Logs from core data */
    func loadLogsFromCoreData() {
        let managedContext = self.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Log")
        do {
            let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            for managedObject in fetchResult! {
                let newLog = Log()
                newLog.name = managedObject.valueForKey("name") as! String
                newLog.date = managedObject.valueForKey("date") as! NSDate
                let loadedCoordinates = managedObject.valueForKey("coordinate") as! [String]
                for loadedCoordinate in loadedCoordinates {
                    let coordinate = loadedCoordinate.convertToCLLocationCoordinate()
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    newLog.locationArray.append(location)
                }
                appDelegate.logList.append(newLog)
            }
            
        } catch {
            
        }
    }
    
    /** Add Log to Core Data */
    func addLogToCoreData(log: Log) {
        let managedContext = self.appDelegate.managedObjectContext
        // add new project into core data
        let entity =  NSEntityDescription.entityForName("Log",
            inManagedObjectContext:
            managedContext)
        
        let logEntity = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        logEntity.setValue(log.name, forKey: "name")
        logEntity.setValue(log.date, forKey: "date")
        var locationStringArray: [String] = []
        for location in log.locationArray {
            locationStringArray.append(location.coordinate.convertToSaveInCoreData())
        }
        logEntity.setValue(locationStringArray, forKey: "coordinate")
        do {
            try managedContext.save()
        } catch {
            print("Error when adding new project")
        }
    }
}
