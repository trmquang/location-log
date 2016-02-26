//
//  LoggingViewController.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/23/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit
import CoreLocation

class LoggingViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    var locationManager: CLLocationManager?
    var distanceFilter: Double = 50
    var visitedLocations: [CLLocation] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var coordinateLabel: UILabel!
    
    // MARK: - View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init Location Manager
        CLLocationManager.locationServicesEnabled()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = self.distanceFilter
        locationManager?.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if locationManager != nil {
            locationManager?.startUpdatingLocation()
        }
    }
   
    // MARK: - Location Manager Delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        visitedLocations += locations
        coordinateLabel.text = locations.last?.coordinate.convertToSaveInCoreData()
    }
    
    // MARK: - IBAction methods
    @IBAction func backBtn_Tapped(sender: UIBarButtonItem) {
        locationManager?.stopUpdatingLocation()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowLogDetail" {
            let navigationController = segue.destinationViewController as! LogDetailNavigationController
            let log = Log(name: "New Log", date: NSDate(), locationArray: visitedLocations)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let logDetailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LogDetailViewController") as! LogDetailViewController
            
            logDetailViewController.log = log
            locationManager?.stopUpdatingLocation()
            navigationController.pushViewController(logDetailViewController, animated: true)
        }
    }
}
