//
//  TiresResponceModel.swift
//  TREEL
//
//  Created by Treel Mobility  on 24/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class TiresResponceModel: BaseApiResponse {
    var vehicleData : [VehicleData]?

    override func mapping(map: Map) {
        vehicleData <- map["data"]
        msg <- map["message"]
        errCode <- map["errorCode"]
        isSuccess <- map["success"]
        errCodeStr <- map["errorCode"]
    }
    
    
}

class VehicleData: Mappable {
   
    var VehicleID: String?
    var DeviceID: String?
    var ReceivedDateTime: String?
    var DeviceDateTime: String?
    var Latitude: String?
    var Longitude: String?
    var Speed: String?
    var VehicleBattery: String?
    var Event: String?

    var Temp_0: String?
    var Pres_0: String?
    var Bat_0: String?
    var Event_0: String?
    
    var Temp_1: String?
    var Pres_1: String?
    var Bat_1: String?
    var Event_1: String?
   
    var Temp_2: String?
    var Pres_2: String?
    var Bat_2: String?
    var Event_2: String?
    
    var Temp_3: String?
    var Pres_3: String?
    var Bat_3: String?
    var Event_3: String?
    
    var Temp_4: String?
    var Pres_4: String?
    var Bat_4: String?
    var Event_4: String?
    
    var Temp_5: String?
    var Pres_5: String?
    var Bat_5: String?
    var Event_5: String?
    
    var Temp_6: String?
    var Pres_6: String?
    var Bat_6: String?
    var Event_6: String?
    
    var Temp_7: String?
    var Pres_7: String?
    var Bat_7: String?
    var Event_7: String?
    
    var Temp_8: String?
    var Pres_8: String?
    var Bat_8: String?
    var Event_8: String?
    
    var Temp_9: String?
    var Pres_9: String?
    var Bat_9: String?
    var Event_9: String?
    
    var Temp_10: String?
    var Pres_10: String?
    var Bat_10: String?
    var Event_10: String?
    
    var Temp_11: String?
    var Pres_11: String?
    var Bat_11: String?
    var Event_11: String?
    
    var Temp_12: String?
    var Pres_12: String?
    var Bat_12: String?
    var Event_12: String?
    
    var Temp_13: String?
    var Pres_13: String?
    var Bat_13: String?
    var Event_13: String?
    
    var Temp_14: String?
    var Pres_14: String?
    var Bat_14: String?
    var Event_14: String?
    
    var Temp_15: String?
    var Pres_15: String?
    var Bat_15: String?
    var Event_15: String?
    
    var Temp_16: String?
    var Pres_16: String?
    var Bat_16: String?
    var Event_16: String?
    
    var Temp_17: String?
    var Pres_17: String?
    var Bat_17: String?
    var Event_17: String?
    
    var Temp_18: String?
    var Pres_18: String?
    var Bat_18: String?
    var Event_18: String?
    
    var Temp_19: String?
    var Pres_19: String?
    var Bat_19: String?
    var Event_19: String?
    
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        VehicleID <- map["VehicleID"]
        ReceivedDateTime <- map["ReceivedDateTime"]
        DeviceID <- map["DeviceID"]
        DeviceDateTime <- map["DeviceDateTime"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        Speed <- map["Speed"]
        
        Temp_0 <- map["Temp_0"]
        Pres_0 <- map["Pres_0"]
        Event_0 <- map["Event_0"]
        Bat_0 <- map["Bat_0"]
        
        Temp_1 <- map["Temp_1"]
        Pres_1 <- map["Pres_1"]
        Event_1 <- map["Event_1"]
        Bat_1 <- map["Bat_1"]
        
        Temp_2 <- map["Temp_2"]
        Pres_2 <- map["Pres_2"]
        Event_2 <- map["Event_2"]
        Bat_2 <- map["Bat_2"]
        
        Temp_3 <- map["Temp_3"]
        Pres_3 <- map["Pres_3"]
        Event_3 <- map["Event_3"]
        Bat_3 <- map["Bat_3"]
        
        Temp_4 <- map["Temp_4"]
        Pres_4 <- map["Pres_4"]
        Event_4 <- map["Event_4"]
        Bat_4 <- map["Bat_4"]
        
        Temp_5 <- map["Temp_5"]
        Pres_5 <- map["Pres_5"]
        Event_5 <- map["Event_5"]
        Bat_5 <- map["Bat_5"]
        
        
        Temp_6 <- map["Temp_6"]
        Pres_6 <- map["Pres_6"]
        Event_6 <- map["Event_6"]
        Bat_6 <- map["Bat_6"]
        
        
        Temp_7 <- map["Temp_7"]
        Pres_7 <- map["Pres_7"]
        Event_7 <- map["Event_7"]
        Bat_7 <- map["Bat_7"]
        
        
        Temp_8 <- map["Temp_8"]
        Pres_8 <- map["Pres_8"]
        Event_8 <- map["Event_8"]
        Bat_8 <- map["Bat_8"]
        
        
        Temp_9 <- map["Temp_9"]
        Pres_9 <- map["Pres_9"]
        Event_9 <- map["Event_9"]
        Bat_9 <- map["Bat_9"]
        
        
        Temp_10 <- map["Temp_10"]
        Pres_10 <- map["Pres_10"]
        Event_10 <- map["Event_10"]
        Bat_10 <- map["Bat_10"]
        
        Temp_11 <- map["Temp_11"]
        Pres_11 <- map["Pres_11"]
        Event_11 <- map["Event_11"]
        Bat_11 <- map["Bat_11"]
        
        
        Temp_12 <- map["Temp_12"]
        Pres_12 <- map["Pres_12"]
        Event_12 <- map["Event_12"]
        Bat_12 <- map["Bat_12"]
        
        
        Temp_13 <- map["Temp_13"]
        Pres_13 <- map["Pres_13"]
        Event_13 <- map["Event_13"]
        Bat_13 <- map["Bat_13"]
        
        Temp_14 <- map["Temp_14"]
        Pres_14 <- map["Pres_14"]
        Event_14 <- map["Event_14"]
        Bat_14 <- map["Bat_14"]
        
        Temp_15 <- map["Temp_15"]
        Pres_15 <- map["Pres_15"]
        Event_15 <- map["Event_15"]
        Bat_15 <- map["Bat_15"]
        
        Temp_16 <- map["Temp_16"]
        Pres_16 <- map["Pres_16"]
        Event_16 <- map["Event_16"]
        Bat_16 <- map["Bat_16"]
        
        Temp_17 <- map["Temp_17"]
        Pres_17 <- map["Pres_17"]
        Event_17 <- map["Event_17"]
        Bat_17 <- map["Bat_17"]
        
        Temp_18 <- map["Temp_18"]
        Pres_18 <- map["Pres_18"]
        Event_18 <- map["Event_18"]
        Bat_18 <- map["Bat_18"]
        
        
        Temp_19 <- map["Temp_19"]
        Pres_19 <- map["Pres_19"]
        Event_19 <- map["Event_19"]
        Bat_19 <- map["Bat_19"]
        
        
    }
}

