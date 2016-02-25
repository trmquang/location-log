//
//  Log.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/23/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import Foundation
import CoreLocation

class Log {
    var name: String!
    var date: NSDate!
    var locationArray: [CLLocation] = []
    
    /** Default init */
    init() {
        self.name = ""
        self.date = NSDate()
        locationArray = []
    }
    
    /** Init with name */
    init(name: String) {
        self.name = name
        self.date = NSDate()
        locationArray = []
    }
    
    /** Init with name and date */
    init(name: String, date: NSDate) {
        self.name = name
        self.date = date
        locationArray = []
    }
    
    /** Init with name, date and array of locations */
    init(name: String, date: NSDate, locationArray: [CLLocation]) {
        self.name = name
        self.date = date
        self.locationArray += locationArray
    }
    
}