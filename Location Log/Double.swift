//
//  Double.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/24/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import Foundation

extension Double {
    func toStringWithFormat(f: String) -> String {
        return String(format: "%\(f)f",self)
    }
}