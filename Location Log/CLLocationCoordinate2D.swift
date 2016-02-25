//
//  CoreDataConversion.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/24/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func convertToSaveInCoreData() -> String {
        let result = self.latitude.toStringWithFormat(".14") + "," + self.longitude.toStringWithFormat(".14")
        return result
    }
}