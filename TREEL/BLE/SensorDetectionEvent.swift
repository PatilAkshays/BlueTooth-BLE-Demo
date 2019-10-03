//
//  SensorDetectionEvent.swift
//  Treel
//
//  Created by Prasanna Rege on 8/21/18.
//  Copyright © 2018 Prasanna Rege. All rights reserved.
//

import Foundation

class SensorDetectionEvent: NSObject {
    var tagID: String!
    var sensorData: String!
    var sensorDetectionTimestamp: String!
    var lowPressureDetectionTimestamp: String?
    var highPressureDetectionTimestamp: String?
    var highTemperatureDetectionTimestamp: String?
    
}
