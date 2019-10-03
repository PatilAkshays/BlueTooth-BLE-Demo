//
//  APIException.swift
//  TMass
//
//  Created by Treel Mobility  on 26/03/19.
//  Copyright © 2019 AkshAy Patil . All rights reserved.
//


import UIKit

enum APIException: Error {
    case apiFailed(errMsg: String)
}

