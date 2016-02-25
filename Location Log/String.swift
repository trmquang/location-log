//
//  String.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/24/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import Foundation
import CoreLocation

extension String {
    func convertToCLLocationCoordinate() -> CLLocationCoordinate2D {
        let coordinateArray = self.componentsSeparatedByString(",")
        let latitude = Double(coordinateArray[0])
        let longitude = Double(coordinateArray[1])
        let result = CLLocationCoordinate2DMake(latitude!, longitude!)
        return result
    }
}