//
//  APIError.swift
//  TMass
//
//  Created by Treel Mobility  on 26/03/19.
//  Copyright © 2019 AkshAy Patil . All rights reserved.
//


import UIKit

class APIError {
    var errStatus: Bool = false
    var errMsg: String?
}

struct ApiErrorCode {
    public static let userNotVerified = 505
}
