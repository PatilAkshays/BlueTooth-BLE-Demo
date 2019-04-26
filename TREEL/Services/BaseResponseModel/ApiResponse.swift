//
//  ApiResponse.swift
//  Treel
//
//  Created by Prasanna Rege on 2/7/18.
//  Copyright © 2018 Prasanna Rege. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseApiResponse: Mappable {
    var msg : String?
    var errCode : Int?
    var errCodeStr : String?

    var isSuccess : Bool?
    
    required public init?(){}
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        msg <- map["message"]
        errCode <- map["errorCode"]
        isSuccess <- map["success"]
        errCodeStr <- map["errorCode"]
    }

}
