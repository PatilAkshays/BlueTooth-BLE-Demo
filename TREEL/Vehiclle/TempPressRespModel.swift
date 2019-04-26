//
//  TempPressRespModel.swift
//  TREEL
//
//  Created by Treel Mobility  on 24/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class TempPressRespModel: BaseApiResponse {
    var vehicledetails : [Vehicledetails]?
    
    override func mapping(map: Map) {
        vehicledetails <- map["data"]
        msg <- map["message"]
        errCode <- map["errorCode"]
        isSuccess <- map["success"]
        errCodeStr <- map["errorCode"]
    }
    
    
}

class Vehicledetails: Mappable {
    
    var temp: String?
    var press: String?
   
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        temp <- map["Temp_0"]
        press <- map["Pres_0"]
        
    }
}

